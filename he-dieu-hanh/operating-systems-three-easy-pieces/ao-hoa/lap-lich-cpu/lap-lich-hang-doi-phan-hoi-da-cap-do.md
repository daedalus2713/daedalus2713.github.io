---
description: The Multi-Level Feedback Queue MLFQ
---

# Lập lịch: Hàng đợi phản hồi đa cấp độ

## 1. Các quy tắc cơ bản

\_ Hàng đợi phản hồi đa cấp:

* Gồm nhiều hàng đợi riêng biệt
* Các hàng đợi được phân mức độ ưu tiên khác nhau
* Một job sẵn sàng được chạy sẽ ở trên 1 hàng đợi nhất định

\_ 2 quy tắc cơ bản của MLFQ:

* Chạy job có độ ưu tiên cao hơn
* Nếu các job có cùng độ ưu tiên, thì chạy theo round robin

\_ MLFQ đặt độ ưu tiên cho các job dựa vào các hành vi quan sát được của job:

* Job thường xuyên đợi input từ bàn phím sẽ được giữ ở độ ưu tiên cao
* Job thường xuyên sử dụng CPU trong thời gian dài thì sẽ bị giảm độ ưu tiên
* =&gt; MLFQ cố gắng dùng lịch sử của các job để dự đoán hành động sắp tới

## 2. Thay đổi độ ưu tiên

\_ Quy tắc 3: Khi vừa nhận được 1 job, đặt job đó ở độ ưu tiên cao nhất  
\_ Quy tắc 4a: Nếu 1 job dùng hết cả time slice khi chạy, giảm độ ưu tiên của job  
\_ Quy tắc 4b: Nếu 1 job trả lại CPU khi time slice chưa hết, giữ nguyên độ ưu tiên

\_ Các vấn đề khi sử dụng MLFQ:

* **Đói tài nguyên** \(starvation\): Nếu có quá nhiều job tương tác \(cần nhiều thao tác I/O\), thì các job đó sẽ tiêu tốn hết thời gian chạy CPU, làm cho các job có thời gian chạy lâu\(độ ưu tiên thấp không được chạy\)
* Một chương trình tuy chạy dài nhưng sẽ luôn thực hiện các thao tác I/O trước khi time slice hết để có thể giữ mức ưu tiên cao. Từ đó độc chiếm CPU
* Một chương trình có thể thay đổi hành vi của nó theo thời gian, có giai đoạn thực hiện nhiều thao tác I/O cũng như có các giai đoạn cần thực hiện ít.

## 3. Tăng độ ưu tiên

\_ Để tránh các vấn đề lưu trong mục \(2\) ta có thể định kỳ tăng độ ưu tiên của tất cả các job trong hệ thống, đơn giản nhất: **Quy tắc 5:** Sau 1 khoảng thời gian S', đưa toàn bộ job lên độ ưu tiên cao nhất.

* Giải quyết được 2 vấn đề: Đói tài nguyên và khi 1 job trở nên interactive, bộ lập lịch sẽ có thể phân độ ưu tiên tốt hơn
* Thời gian S' cần phải hợp lý, nếu bị cài đặt quá cao, các job chạy lâu hoặc các job interactive sẽ không được phân bổ CPU.

## 4. Better Accounting - Quản lý tốt hơn

\_ Để tránh việc đánh lừa bộ lập lịch, giải pháp để có thể quản lý thời gian tốt hơn cho CPU là theo dõi thời gian sử dụng CPU của các job, khi job sử dụng hết thời gian được phân bổ thì sẽ bị giảm độ ưu tiên.

\_ Quy tắc 4: Khi job sử dụng hết thời gian được phân bổ ở mức độ phân quyền hiện tại thì sẽ được chuyển xuống độ ưu tiên thấp hơn.

## 5. Điều chỉnh MLFQ và các vấn đề khác

\_ Câu hỏi đầu tiên được đặt ra là làm sao có thể tham số hóa bộ lập lịch:

* Cần có bao nhiều hàng đợi ? 
* Độ dài của time slice ? 
* Thời gian tăng độ ưu tiên ?
* ........

\_ Thường các bộ lập lịch cho phép tùy chỉnh các time slice khác nhau cho từng hàng đợi, các hàng đợi có độ ưu tiên cao có time slice ngắn hơn.

\_ Có 2 cách để điều chỉnh bộ lập lịch MLFQ:

* Dựa vào các bảng để cài đặt theo nhu cầu của người sử dụng
* Dựa vào các hàm toán học để tự điều chỉnh

