# API của luồng

## 1. Tạo luồng

```text
pthread_create(        pthread_t *      thread,
                const  pthread_attr_t * attr,
                       void *           (*start_routine)(void*),
                       void *           arg);
```

* pthread\_t: phần tử để điều khiển luồng
* attr: đặt các thuộc tính có luồng \(stack size, schedule priority,....\)
* \(\*start\_routine\)\(void\*\): con trỏ hàm, xác định xem hàm nào mà luồng chạy trong đó
* arg: Các đối số cung cấp cho luồng khi luồng thực thi

## 2. Đợi luồng

```text
int pthread_join(pthread_t thread, void **value_ptr);
```

* thread: xác định luồng cần phải đợi
* \*\*value\_ptr: giá trị mong muốn được trả về \(có thể để là NULL nếu không cần gtrị trả về\)

{% hint style="danger" %}
Không được trả về con trỏ của các phần tử được khởi tạo trong luồng
{% endhint %}

\_ Các chương trình chạy trong thời gian dài có thể sẽ không cần đợi các luồng hoàn thành để tiếp tục thực thi

## 3. Khóa

```text
int pthread_mutex_lock(pthread_mutex_t *mutex);
int pthread_mutex_unlock(pthread_mutex_t *mutex);
```

* mutex: biến khóa để tương tác

\_ Đảm bảo việc truy cập các tài nguyên găng

\_ Hàm lock sẽ đưa luồng vào trạng thái block và đợi để có thể lấy được khóa và khóa lại. Chỉ trả về khi đã lấy được khóa

{% hint style="warning" %}
Biến khóa cần phải được khởi tạo một cách thích hợp  
              pthread\_mutext\_t lock = PTHREAD\_MUTEX\_INITIALIZER;  
Khởi tạo các giá trị mặc định cho khóa.
{% endhint %}

\_ Cần phải kiểm tra error khi khóa & mở khóa 

\_ Có thể sử dụng **trylock\(\)** và **timedlock\(\)** để phòng tránh các lỗi xảy ra khi muốn khóa tài nguyên.

## 4. Biến điều kiện

\_ Truyền tín hiệu giữa các luồng với nhau

```text
int pthread_cond_wait(pthread_cond_t *cond, pthread_mutex_t *mutex);
int pthread_cond_signal(pthread_cond_t *cond);
```

* cond: biến điều kiện
* mutex: khóa

\_ Để sử dụng biến điều kiện thì cần sử dụng thêm một khóa đi kèm. Nhằm tránh việc xảy ra **race conditions** khi sử dụng biến điều kiện chung.

\_ Việc dùng biến điều kiện mà không dùng vòng lặp giúp tránh lãng phí thời gian CPU hoạt động và tránh lỗi

