# Phân trang: Dùng bảng nhỏ hơn

* Các bảng phân trang có kích thước khá lớn và có thể chiếm nhiều dung lượng bộ nhớ.
* Nếu sử dụng mỗi một bảng phân trang cho một tiến trình thì số lượng bảng phân trang cũng không nhỏ.

## 1. Tăng kích thước trang

\_ Giảm số lượng Page Table Entry trong một bảng phân trang

\_ Có thể dẫn tới phân mảnh trong

## 2. Kết hợp phân trang và phân đoạn

\_ Một bảng phân trang có thể bao gồm nhiều bản ghi không hợp lệ \(các trang không được cấp phát\). Dẫn tới chi phí bộ nhớ lớn để lưu các thông tin không cần thiết.

\_ Giải pháp: Có một bảng phân trang cho mỗi phân đoạn logic

* Base: Chỉ tới địa chỉ vật lý của trang
* Bound: Giới hạn của trang
* Sử dụng thêm bit để phân biệt các phân đoạn \(code, heap, stack,...\)

\_ Điểm trừ:

* Phải cài đặt để sử dụng phân đoạn
* Phân mảnh ngoài, vì có thể cấp phát bộ nhớ tùy ý nên khó có thể tìm được dung lượng trống đủ lớn.

## 3. Bảng phân trang đa cấp

\_ Tổ chức thành một cấu trúc dạng cây, thêm cấu trúc dữ liệu mới là **thư mục trang \(page directory\)** chỉ tới địa chỉ của các bảng phân trang.

\_ Chức năng của thư mục bảng: Giảm kích thước lưu trữ các bảng, chỉ giữ lại các bảng thực sự đang có bộ nhớ được cấp phát.

\_ Thư mục bảng:

* Là một bảng 2 mức độ: chứa địa chỉ của các bảng phân trang
* Bao gồm các **Page Directory Entries** \(PDE\)
* Nếu PDE không hợp lệ thì các dữ liệu của PDE sẽ không được lưu vào trong bộ nhớ.

\_ Ưu điểm:

* Chỉ cần dùng bộ nhớ cho thư mục bảng và các bảng cần thiết, làm giảm không gian bộ nhớ
* Dễ dàng quản lý các trang, có thể chia nhỏ các trang để cấp phát bộ nhớ

\_ Nhược điểm:

* Chi phí lớn khi xảy ra TLB miss, thêm 1 lần tra cứu thư mục bảng
* Phức tạp khiu cài đặt

## 4. Bảng phân trang đảo ngược

\_ Chỉ sử dụng 1 bảng phân trang duy nhất cho toàn hệ thống, định dang các tiến trình khi cấp phát trang nhớ.

\_ Tra cứu tuyến tính sẽ rất mất thời gian, nên cần các cấu trúc dữ liệu hỗ trợ tăng tốc tìm kiếm.

