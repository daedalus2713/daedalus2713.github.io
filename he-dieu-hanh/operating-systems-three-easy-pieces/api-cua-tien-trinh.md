---
description: 'Các API thực tế, thường được dùng trong các hệ điều hành UNIX'
---

# API của tiến trình

## 1. Lời gọi hàm fork\(\):

Dùng để tạo một tiến trình mới. Tiến trình mới được tạo ra gần như là một bản sao hoàn chỉnh của tiến trình gọi hàm fork\(\), dù tiến trình con có vùng nhớ riêng, thanh ghi riêng,....

Khi hàm này được gọi thành công:

* Tiến trình cha sẽ nhận được ID của tiến trình con
* Tiến trình con sẽ nhận được mã trả về là 0 

Khi tiến trình con được tạo mới, bộ xếp lịch của CPU sẽ sắp xếp thứ tự chạy của các tiến trình, có thể dẫn tới các khó khăn trong lập trình đa luồng.

## 2. Lời gọi hàm wait\(\):

 Dùng để tiến trình cha đợi cho tiến trình con xong việc rồi mới tiếp tục thực thi.

Hàm này sẽ trả về giá trị khi tiến trình con thực thi xong. 

Lời gọi hàm này giúp việc quản lý đầu ra của chương trình theo ý muốn của người lập trình dễ dàng hơn. 

## 3. Lời gọi hàm exec\(\):

Dùng để khởi chạy một chương trình khác được gọi từ một chương trình đang chạy.

Khi gọi hàm này, phần code \(dữ liệu tĩnh\) sẽ được ghi đè vào phần  code hiện tại, các vùng nhớ của chương trình cũng sẽ được khởi tạo lại, sau đó HĐH sẽ chạy chương trình với các tham số được cho.

## 4. Pipes trong UNIX:

Diễn tả một chuỗi các hành động được thực thi như 1 chương trình, bằng cách gọi nhiều chương trình từ UNIX shell. 

Với lời gọi hàm pipe\(\), đầu ra của chương trình này sẽ được kết nối tới 1 pipe trong kernel của HĐH và trở thành đầu ra của chương trình được kết nối vào cùng pipe đó. 

## 5. Quản lý tiến trình và người dùng:

Ngoài các API trên, HĐH cung cấp rất nhiều API để có thể tương tác với tiến trình. Ví dụ như hàm kill\(\) - gửi tín hiệu đến tiến trình để dừng, tạm dừng,...

HĐH cung cấp rất nhiều cách để đưa một sự kiện tới tiến trình cụ thể cũng như toàn bộ **1 nhóm tiến trình \(process groups\).**

Điều này dẫn tới vấn đề rằng ai có thể gửi tín hiệu và ai không. Vì vậy,  các HĐH hiện đại đã tạo ra khái niệm **người dùng**. Một người dùng có thể điều khiển tiến trình của chính họ, còn HĐH sẽ phụ trách việc quản lý và phân chia tài nguyên giữa các người dùng.



 

