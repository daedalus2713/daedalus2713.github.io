# Khóa

## 1. Ý tưởng ban đầu

\_ Là một biến giữ giá trị của khóa \(đang khóa hoặc không\), đặc biệt là chỉ có **duy nhất một luồng** có thể giữ khóa.

\_ Dùng hàm lock\(\) và unlock\(\) để thay đổi giá trị của khóa, nếu gọi hàm lock\(\) tại một khóa đang bị giữ, tiến trình sẽ đợi tới khi khóa rảnh và khóa lại xong mới trả về.

## 2. Xây dựng khóa

### 2.1. Các yêu cầu

\_ Tính đúng đắn: đảm bảo mutal exclusion

\_ Tính công bằng: các luồng được công bằng nhận khóa, tránh tình trạng **lock starve**.

\_ Hiệu năng: chi phí sử dụng khóa phải đủ nhỏ để tránh không tác động tới hệ thống

### 2.2. Điều khiển interrupts

\_ Tắt các interrupts của hệ thống.

\_ Chỉ dành cho hệ thống đơn nhân.

\_ Đơn giản.

\_ Các nhược điểm:

* Yêu cầu quyền hạn privileged
* Phụ thuộc vào chương trình
* Không sử dụng trên hệ thống đa nhân

### 2.3. Spin locks với Test-And-Set

\_ Dùng sự hỗ trợ của phần cứng để tạo ra một bộ chỉ dẫn có tính **atomic**. Do đó chỉ có một tiến trình có thể chiếm giữ khóa tại một thời điểm.

```text
int TestAndSet(int *old_ptr, int new) {
    int old = *old_ptr;
    *old_ptr = new;
    return old;
}
```

\_ Kiểm tra giá trị cũ \(giá trị trả về\), đồng thời cũng đặt giá trị mới cho biến.

```text
void lock(lock_t *lock) {
    while TestAndSet(&lock->flag,1) == 1 {
        //wait
    }
}
```

### 2.4. Đánh giá spin lock

\_ Nhược điểm của spin lock:

* Không đảm bảo tính công bằng
* Tốn hiệu năng khi luôn có vòng lặp for chạy hết 1 time slice để đợi khóa \(tốn thời gian với hệ thống đơn nhân\)

### 2.5. Compare-And-Swap

```text
int CompareAndSwap(int *ptr, int expected, int new) {
    int actual = *ptr;
    if (actual == expected) {
        *ptr = new;
    }
    return actual;
}
```

\_ Gần giống với TestAndSet tuy nhiên chỉ đặt giá trị mới cho biến khi giá trị bằng expected.

### 2.6. Load-Linked & Store-Conditional

```text
int LoadLinked(int *ptr) {
    return *ptr;
}

int StoreConditional(int *ptr, int value) {
    if (no update to *ptr since LoadLinked to this address) {
        *ptr = value;
        return 1; // OK
    }
    return 0; // FAIL    
}
```

\_ LoadLinked dùng cho việc lấy giá trị từ bộ nhớ và đặt vào register. 

\_ StoreConditional chỉ thành công nếu không có sự can thiệp nào vào giá trị vừa load. 

### 2.7. Fetch-And-Add

```text
int FetchAndAdd(int *ptr) {
    int old = *ptr;
    *ptr = old + 1;
    return old;
}
```

\_ Áp dụng cho khóa có thể cấp phát các thẻ cho tiến trình, và các tiến trình lần lượt đợi đến khi mình có thể giữ được khóa.

```text
typedef struct __lock_t {
    int ticket;
    int turn;
} lock_t;

void lock(lock_t *lock) {
    int myturn = FetchAndAdd(&lock->ticket);
    while (lock->ticket != myturn) {
        // wait
    }
}

void unlock(lock_t *lock) {
    lock->turn = lock->turn + 1;
}
```

### 2.8. Just Yeild, Baby

\_ Tư tưởng: Từ bỏ CPU nếu thấy không thể lấy được khóa.

\_ Ở trường hợp có rất nhiều tiến trình, khi chỉ 1 tiến trình giữ khóa, các tiến trình khác vẫn được lập lịch chạy rồi mới có thể từ bỏ CPU. Dẫn tới chi phí lớn khi phải thực hiện context-switch.

\_ Một tiến trình có thể phải đợi vô thời hạn nếu các tiến trình khác giữ khóa trước nó.

### 2.9. Dùng queue

\_ Đẩy các tiến trình đang đợi vào queue, và chỉ gọi dậy các tiến tình khi có khóa.

\_ HĐH hỗ trợ bằng các hàm _park\(\)_ và _unpark\(\)_ 

\_ Cần phải lấy được ID của các tiến trình cũng như có một CTDL để lưu trữ lại thông tin đó.

\_ Có thể dẫn tới wakeup/waiting race, giải quyết bằng cách dùng hàm _setpark\(\)_, thông báo rằng 1 tiến trình chuẩn bị park, nếu bị ngắt quãng bởi 1 lời gọi unpark\(\) từ hàm khác, setpark\(\) sẽ trả về ngay lập tức.

### 2.10. Futex lock

\_ Được cung cấp bởi HĐH Linux, các hoạt động được đưa xuống kernel nhiều hơn.

\_ Mỗi futex lock sẽ được gắn liền với 1 vị trí trong bộ nhớ vật lý, và có thêm mỗi queue trong futex lock.

\_ Đặc điểm:

* Dùng một biến interger để theo dõi trạng thái khóa và số lượng waiter
* High bit của biến sẽ theo dõi trạng thái \(âm = đang khóa\)
* Low bit chỉ số lượng waiter

### 2.11. 2-phase-lock

\_ Tiến trình sẽ **chỉ spin tại lần đầu tiên** để cố gắng lấy khóa, nếu không được thì tiến trình sẽ được đưa vào trạng tháu ngủ. Chỉ được gọi dậy khi khóa đã rảnh.

\_ Cách tiếp cận Hybrid.

