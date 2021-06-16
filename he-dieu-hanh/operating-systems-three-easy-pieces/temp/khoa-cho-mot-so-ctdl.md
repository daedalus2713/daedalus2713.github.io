# Khóa cho một số CTDL

## 1. Biến đếm

\_ Đơn giản nhưng không có khả năng mở rộng:

* Sử dụng 1 khóa cho biến đếm
* Các luồng sẽ thay phiên nhau gọi khóa để thay đổi giá trị biến đếm
* =&gt; **Toàn bộ các luồng sẽ phải đợi 1 luồng**.

\_ Có thể mở rộng - Biến đếm xấp xỉ:

* Mỗi một luồng sẽ có 1 biến đếm
* Có 1 biến đếm toàn cục \(có khóa\)
* Định kỳ, các biến đếm luồng sẽ được cộng vào biến đếm toàn cục
* Đánh đổi **tính chính xác / hiệu năng**.

## 2. Danh sách liên kết

\_ Cách đơn giản: Có 1 khóa duy nhất cho toàn bộ danh sách

* Dễ cài đặt
* Các luồng phải chờ đợi rất lâu để duyệt

\_ Cơ chế khóa chuyền tay \(hand-over-hand locking\):

* Có mỗi khóa cho 1 node
* Khi duyệt tuần tự:
  * Lấy khóa của node tiếp theo
  * Mở khóa node đang duyệt
* =&gt; Có overhead tại liên tục khóa và mở khóa

## 3. Hàng đợi 

\_ Đơn giản: Có 1 khóa chung cho toàn bộ

\_ Micheal & Scott:

* Có 2 khóa tại 2 đầu: bảo đảm việc pop & push dữ liệu đồng thời
*  Có 1 node ảo, giúp phân chia 2 đầu của hàng đợi

## 4. Hash table

\_ Coi các bucket của hash table là danh sách liên kết

\_ Chỉ có 1 khóa cho mỗi danh sách liên kết \(hash bucket\) 

