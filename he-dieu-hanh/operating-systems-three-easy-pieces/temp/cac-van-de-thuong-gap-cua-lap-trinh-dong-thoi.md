# Các vấn đề thường gặp của lập trình đồng thời

## 1. Các lỗi non-deadlock

### 1.1. Vi phạm tính nguyên tử \(Atomicity\)

{% hint style="info" %}
The desired serializability among multiple memory access is violated
{% endhint %}

\_ Giải pháp: Thêm **khóa** cho các tài nguyên găng

### 1.2. Vi phạm thứ tự thực thi

{% hint style="info" %}
The desired order between two \(groups of\) memory access is flipped
{% endhint %}

\_ Giải pháp: Thêm các để bắt buộc các luồng phải thực thi theo thứ tự, ví dụ như dùng **biến điều kiện**.

## 2. Các lỗi về deadlocks

\_ Các lỗi này không nhất thiết sẽ xảy ra mà có thể xảy ra trong một số tình huống nhất định.

\_ Lý do xảy ra deadlocks

* Lượng code lớn, các phụ thuộc phức tạp
* Tính đóng gói
  * Che giấu các thông tin triển khai
  * Các interfaces vô thưởng vô phạt thường dẫn tới deadlocks

\_ Điều kiện để xảy ra deadlocks

* Cần phải đáp ứng cả 4 điều kiện
* Loại trừ lẫn nhau: Luồng sẽ độc chiếm các tài nguyên mà nó cần
* Giữ và đợi \(Hold-and-wait\): Luồng sẽ giữ các tài nguyên được cấp phát khi nó chờ đợi các tài nguyên khác
* Không ưu tiên: Các tài nguyên không thể bị tước đi khỏi các luồng đang giữ nó
* Chờ đợi vòng tròn: Có một hàng đợi vòng tròn mà mỗi luồng sẽ giữ 1 hay nhiều tài nguyên mà luồng tiếp theo trong hàng đợi cần sử dụng

### 2.1. Các cách phòng tránh deadlocks

#### 2.1.1. Hàng đợi vòng tròn

\_ Phòng tránh việc xuất hiện hàng đợi vòng tròn trong code

\_ Total ordering: Luôn luôn đảm bảo các khóa được lấy theo một thứ tự nhất định

\_ Partial ordering: Các nhóm khóa sẽ được chia nhóm và trong mỗi nhóm cần một thứ tự lấy khóa nhất định

#### 2.1.2. Đợi và giữ

\_ Luôn luôn lấy toàn bộ các khóa trong một lần

\_ Có 1 khóa global giúp cho đảm bảo chỉ có 1 luồng đang lấy các khóa

\_ Vấn đề: Giảm thiều tính đồng thời vì lấy các khóa sớm thay vì là chỉ lấy các khóa lúc cần sử dụng

#### 2.1.3. Không ưu tiên

\_ Sử dụng hàm **trylock\(\)** sẽ trả về lỗi nếu không lấy được khóa.

\_ Vấn đề: **livelock**

* Cả 2 luồng đều liên tục lấy khóa theo thứ tự ngược nhau và liên tục thất bại
* Cách giải quyết: thêm thời gian delay ngẫu nhiên trước khi tiến hành lấy khóa

\_ Vấn đề khác là để luồng bắt đầu lại nếu lấy khóa thất bại thường rất phức tạp vì phải khôi phục trạng thái của các tài nguyên đã được luồng đó thay đổi.

#### 2.1.4. Loại trừ lẫn nhau

\_ Thay vì sử dụng khóa thì có thể sử dụng các chỉ dẫn do phần cứng hỗ trợ

* Compare-and-swap
* Test-and-set

#### 2.1.5. Dựa vào bộ lập lịch

\_ Các bộ lập lịch có thể tính toán xem các luồng nào sẽ tạo deadlock nếu chạy song song và chuyển chúng về chạy tuần tự

\_ Dẫn tới giảm hiệu năng hệ thống vì chỉ cần 1 phần có thể xảy ra deadlock mà toàn bộ các luồng đó phải chạy tuần tự

\_ Không được sử dụng rộng rãi

#### 2.1.6. Phát hiện và khôi phục

\_ Cho phép các deadlock có thể xảy ra \(thỉnh thoảng\).

\_ Có 1 trình phát hiện deadlock sẽ được chạy định kỳ, xây dựng một một đồ thị tài nguyên và kiểm tra các chu trình.

\_ Nếu có deadlock xảy ra, các biện pháp khôi phục \(khởi động lại\) sẽ được tiến hành.

