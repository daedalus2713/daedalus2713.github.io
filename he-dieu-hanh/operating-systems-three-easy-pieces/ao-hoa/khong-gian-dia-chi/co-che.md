# Cơ chế

\_ Cần phải hỗ trợ các yêu cầu về bộ nhớ lớn, thậm chí lớn hơn cả dung lượng của bộ nhớ trong.

\_ Cho phép các tiến trình có thể yêu cầu cấp phát bộ nhớ theo như mong muốn.

## 1. Hoán đổi không gian

\_ Để dành các không gian trên bộ nhớ ngoài để có thể tạm thời lưu trữ các trang. HĐH cần phải lưu trữ lại địa chỉ để có thể truy cập.

\_ Dung lượng của phân vùng hoán đổi cũng giới hạn lại số trang được lưu trữ thêm bên ngoài bộ nhớ.

## 2. Bit hiển thị

\_ Thường được dùng để xác định vị trí của trang xem đang ở trong bộ nhớ ngoài hay bộ nhớ trong.

\_ Mỗi lần tra cứu địa chỉ của trang, bit hiển thị sẽ được kiểm tra, nếu trang đó đang ở bộ nhớ ngoài thì cần hoán đổi vào bộ nhớ trong và cập nhập TLB.

\_ Việc truy cập đến trang không hiển thị thường sẽ tạo ra một **lỗi trang**.

## 3. Lỗi trang

\_ Khi một trang không tồn tại trong hệ thống, HĐH cần phải xử lý.

\_ Thường sẽ kiểm tra bảng phân trang để tìm kiếm địa chỉ trang ở bộ nhớ ngoài và yêu cầu đọc từ ổ đĩa rồi chuyển chúng vào bộ nhớ trong.

\_ Khi quá trình vào ra hoàn tất, Bit hiển thị được cập nhật cùng với các dữ liệu của bảng phân trang.

\_ Trong quá trình thực hiện thao tác vào ra, tiến trình ở trạng thái **blocked.** Từ đó, HĐH có thể tự do chạy các tiến trình đang sẵn sàng.

## 4. Bộ nhớ đầy

\_ Thường sẽ phải xóa các trang \(**page out**\) hiện có để tạo thêm không gian mới cho các trang mới.

\_ Việc xóa các trang sẽ sử dụng chính sách thay thế trang, vì việc xóa nhầm trang có thể dẫn tới tổn hại lớn cho hệ thống.

## 5. Luồng điều khiển lỗi trang

\_ Khi một trang hợp lệ và hiển thị trong bảng phân trang, thì HĐH chỉ cần cập nhật lại TLB.

\_ Khi trang hợp lệ, nhưng không hiển thị, cần phải lấy dữ liệu từ bộ nhớ ngoài.

\_ Khi trang không hợp lệ, thường sẽ tạo ra lỗi và xóa bỏ tiến trình truy cập tới trang không hợp lệ.

## 6. Thay thế trang

\_ Tạo không gian trống cho các trang mới

\_ Duy trì không gian trống vừa đủ: Sử dụng high watermark \(HW\), low watermark \(LW\)

* LW: giới hạn tối thiểu của số trang trống, khi số trang trống nhỏ hơn LW tiến trình thay thế trang sẽ được chạy
* HW: Số trang trống cần thiết sau khi chạy tiến trình thay thế trang. 

\_ Có thể gộp thay thế nhiều trang cùng một lúc để tăng tốc độ xử lý.

