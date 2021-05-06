# Phân trang: Tăng tốc chuyển đổi địa chỉ

\_ Việc sử dụng phân trang dẫn tới việc tốn thêm chi phí trong việc tính toán chuyển đổi địa chỉ như ánh xạ và thêm không lưu trữ.

\_ Để tăng tốc việc chuyển đổi địa chỉ, người ta thêm 1 cấu trúc phần cứng là _translation-lookaside buffer_ \(**TLB**\) hay còn được gọi là _bộ đệm chuyển đổi địa chỉ_ \(**address-translation cache**\)

## 1. Thuật toán của TLB

\_ Mỗi khi chuyển đổi từ VPN sang PFN thì HĐH sẽ tìm kiếm trong TLB:

* TLB hit: Tìm thấy dữ liệu -&gt; trả về kết quả
* TLB miss: Không thấy dữ liệu. Tìm trong bộ nhớ và cập nhật lại TLB và trả về kết quả
* Khi TLB miss xảy ra dẫn tới chi phí lớn lên HĐH để chuyển đổi địa chỉ.

{% hint style="info" %}
Caching:

* Tính cục bộ về thời gian: Khi một dữ liệu được truy cập thì sẽ có khả năng cao truy cập trong thời gian tới.
* Tính cục bộ về không gian: Các dữ liệu được lưu gần dữ liệu vừa được truy cập thì khả năng cao sẽ được truy cập.
* Để thời gian tìm kiếm nhỏ thì cần giữ kích thước cache nhỏ.
{% endhint %}

## 2. TLB miss

\_ **Cách thứ nhất**: Phần cứng xử lý - được cài đặt một bộ chỉ dẫn phức tạp để truy cứu Page table và tìm đúng Page table entry, đưa vào TLB.

* Cần phải có cấu trúc dữ liệu chính xác so với phần cứng định nghĩa trước
* Hardware-managed TLB

\_ **Cách thứ hai**: Việc xử lý được chuyển cho phần mềm

* Chương trình sẽ tạo ra một exception
* HĐH sẽ nâng quyền thành kernel mode, tạo một trap handler và tìm kiếm địa chỉ trong Page table
* Cập nhật vào TLB
* Thử lại chỉ dẫn
* **Tính linh hoạt**: HĐH có thể sử dụng bất kỳ CTDL nào để cài đặt page table.
* **Tính đơn giản**: Không yêu cầu phần cứng làm gì nhiều.

\_ Cần đảm bảo mỗi khi xử lý TLB miss sẽ không dẫn tới 1 chuỗi TLB miss, ví dụ như dành ra các ô trống để lưu trữ dài hạn các chỉ dẫn code.

## 3. Nội dung TLB

\_ VPN \| PFN \| other bits

\_ Các bit khác khá giống với Page table, như protection, address-space identifier, dirty bit,...

## 4. Context switch

\_ TLB chỉ chứa các chuyển đổi cho tiến trình hiện tại

\_ Cách xử lý đơn giản là xóa toàn bộ TLB để cập nhật lại 

* được hoàn thành bởi chuyển hết các valid bit thành 0.
* Chi phí: Toàn bộ các truy cập tới TLB ban đầu của tiến trình sẽ miss

\_ Giảm thiểu chi phí có thể thêm các trường như address space identifier \(tương tự như process ID\) để giữ được nhiều bản ghi trong TLB trong cùng một thời điểm.

## 5. Cơ chế thay thế TLB

\_ Giảm thiểu tối đa tỷ lệ miss.

\_ Thông thường sẽ là least-recently-used \(LRU\)

\_ Có thể sử dụng random để tránh các corner case



