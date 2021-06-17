# Biến điều kiện \(Condition variables\)

\_ Tồn tại các trường hợp mà luồng cần kiểm tra một điều kiện để có thể tiếp tục thực thi.

\_ Nếu sử dụng một biến chia sẻ, sẽ tốn thời gian của CPU để thực hiện vòng lặp liên tục kiểm tra giá trị biến đó.

## 1. Định nghĩa và luồng \(routines\)

\_ Định nghĩa: 

* Là một hàng đợi mà các luồng có thể tự đặt bản thân vào khi mà một vài trạng thái thực thi \(các điều kiện,...\) chưa được đáp ứng.
* Khi trạng thái thay đổi, các tiến trình trong hàng đợi có thể được gọi dậy \(wake\) lần lượt và tiếp tục thực thi
* Thường gồm 2 hàm 
  * _wait\(\)_: đưa luồng vào trạng thái ngủ
  * _signal\(\)_: gọi luồng tiếp tục thực thi

\_ Khi gọi hàm _wait\(\)_ cần thêm một khóa là tham số:

* Khi thread được gọi dậy, nó cần phải lấy khóa này trước khi trả về
* Tránh việc tạo ra **race conditions** khi luồng cố gắng đưa bản thân về trạng thái ngủ

\_ Cần phải có khóa để tránh race condition ở các biến điều kiện cần kiểm tra

{% hint style="info" %}
Giữ khóa khi gọi **signal\(\)** hoặc **wait\(\)**
{% endhint %}

## **2. Vấn đề Producer/Consumer**

\_ Bài toán:

* Buffer có giới hạn
* Producer chỉ đẩy vào khi buffer còn trống
* Consumer chỉ lấy khi buffer không rỗng

\_ Vì buffer \(độ dài buffer\) là tài nguyên chia sẻ, cần khải đồng bộ hóa các thao tác.

\_ Các trường hợp lỗi có thể xảy ra

* Nhiều consumer cùng lấy một dữ liệu -&gt; cần dùng vòng lặp for để kiểm tra điều kiện
* Consumer gọi dậy các consumer khác \(cả consumer và producer dùng chung biến điều kiện\)

## 3. Điều kiện đảm bảo

\_ Có thể gọi dậy nhầm thread

\_ Thay thế bằng gọi dậy toàn bộ các threads -&gt; chi phí cao do phải gọi nhiều threads

\_ Định nghĩa: _covers all the cases where a thread needs to wake up_.

