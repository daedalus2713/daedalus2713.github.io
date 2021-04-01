# Phân trang: Giới thiệu

Ý tưởng: Chia không gian bộ nhớ thành các phần tử có kích thước cố định.

## 1. Tổng quan

\_ Bộ nhớ vật lý được chia thành các ô nhớ gọi là khung trang \(**frames**\)

* Tính linh hoạt: Hỗ trợ việc trừu tượng hóa bộ nhớ cho không gian địa chỉ
* Tính đơn giản: Chỉ cần đưa số lượng trang cần thiết cho tiến trình yêu cầu

\_ Để có thể quản lý các trang cấp cho tiến trình,  HĐH sử dụng một cấu trúc dữ liệu là bảng phân trang \(**page tables**\)

* Cấu trúc dữ liệu được lưu theo từng tiến trình
* Chứa thông tin ánh xạ từ các trang ảo sang trang vật lý \(Virtual Page Number -&gt; Physical Page/Frame Number\)

## 2. Lưu trữ các bảng phân trang

\_ Mỗi một bản ghi trong trong bảng phân trang được gọi là **Page table entry \(PTE\)**. Thường các bảng phân trang sẽ bao gồm rất nhiều bản ghi dẫn đến có kích thước khá lớn.

\_ Thông tin sẽ được lưu trữ trong bộ nhớ chính để phục vụ việc truy xuất của tiến trình.

\_ Ngoài các thông tin về việc ánh xạ, mỗi một PTE thường có thêm các bit phục vụ việc bảo vệ và quản lý dữ liệu:

* Valid bit: Xem việc chuyển đổi địa chỉ có hợp lệ hay không, có thể đánh dấu các page chưa được cấp là không hợp lệ để giải phóng bộ nhớ
* Protection bits: Thông tin về các quyền của tiến trình với trang
* Dirty bit: Xem trang ảo đã được chỉnh sửa từ khi được load vào hay chưa
* Present bit: Biểu thị việc trang có ở trên bộ nhớ hay ở ổ đĩa
* Reference/acessed bit: Theo dấu truy cập tới các trang của tiến trình \(_Quan trọng cho việc cache_\)

## 3. Tốc độ tra cứu bảng phân trang

\_ Quy trình chuyển đổi địa chỉ:

* Tìm PTE trong bảng phân trang của tiến trình
* Lấy dữ liệu từ bộ nhớ vật lý
* -&gt; cần phải biết được địa chỉ của bảng phân trang của tiến trình
* -&gt; được lưu ở thanh ghi bảng phân trang \(**page-table register**\)

\_ Yêu cầu việc phải tăng số lần truy cập vào bộ nhớ để lấy dữ liệu từ bảng phân trang

\_ Dẫn tới tốc độ chậm và cần cơ chế giải quyết.



