---
description: Các API tương tác với bộ nhớ trong hệ thống UNIX
---

# API của bộ nhớ chính

## 1. Các loại bộ nhớ

\_ Trong C, có 2 loại bộ nhớ được cấp phát là:

* Stack: việc cấp phát và giải phóng được quản lý bởi trình dịch \(compiler\). Có thể gọi là **bộ nhớ tự động**.
* Heap: Cho các biến có thời gian sống dài, cấp phát và giải phóng bộ nhớ được quản lý bởi lập trình viên.

## 2. malloc\(\) - memory allocate

\_ Tác dụng: truyền vào độ lớn của vùng bộ nhớ cần cấp phát, nếu thành công sẽ trả về con trỏ của vùng nhớ đó, nếu không trả về NULL.

\_ Trong C, các tham số của malloc không được truyền vào bằng số nguyên mà được định nghĩa thông qua hàm _sizeof\(type\)._

_\__ Giá trị trả về là con trỏ dạng void nên người dùng cần phải **cast** kiểu cho con trỏ đó.

## 3. free\(\)

\_ Tác dụng: Để giải phóng các vùng nhớ không còn được sử dụng.

\_ Tham số truyền vào: con trỏ của hàm malloc\(\). Do không yêu cầu người dùng truyền vào giá trị độ lớn của vùng nhớ cần giải phóng, thư viện cần phải tự quản lý các giá trị này.

## 4. Các lỗi thường gặp

### 4.1. Quên cấp phát các vùng nhớ 

\_ Một số hàm yêu cầu cần phải cấp phát vùng nhớ trước khi gọi. Thường là khi yêu cầu truyền vào con trỏ.

\_ Thường lỗi này sẽ dẫn tới **segmentation fault**.

### 4.2. Không cấp phát đủ bộ nhớ

\_ Các lỗi không cấp phát đủ nhớ thường được gọi là **buffer overflow**.

\_ Tùy thuộc vào cách hàm malloc\(\) được cài đặt mà lỗi này có thể xảy ra hoặc không, vì một số thư viện malloc\(\) thường cấp phát thêm 1 phần bộ nhớ dư. Nên cho dù chương trình không chỉ ra nhưng vẫn hoạt động được.

### 4.3. Quên khởi tạo bộ nhớ được cấp phát

\_ Không đặt giá trị cho vùng nhớ được cấp phát bởi malloc\(\). Khi chương trình đọc vào cùng nhớ này sẽ xảy ra lỗi **uninitialized read**.

\_ Giá trị vùng nhớ này sẽ thường không được xác định và có thể gây nguy hiểm cho chương trình

### 4.4. Quên giải phóng bộ nhớ

\_ Thường được biết tới là **memory leak**. 

\_ Trong các chương trình chạy thời gian dài, lỗi này dễ dẫn tới việc hết bộ nhớ và yêu cầu cần phải khởi động lại. Kể cả với các ngôn ngữ có **trình thu dọn rác** nếu một vùng bộ nhớ vẫn được dùng tới \(reference\) thì vùng đó vẫn không được giải phóng.

### 4.5. Giải phóng bộ nhớ trước khi sử dụng xong

\_ Thường được gọi là **dangling pointer**.

\_ Dẫn tới chương trình dừng hoạt động, ghi đề lên các giá trị khác.

### 4.6. Giải phóng bộ nhớ lặp lại

\_ Biết tới với tên **double free**.

\_ Gây ra bởi việc free một vùng nhớ được cấp phát nhiều hơn một lần. 

\_ Thường làm rối các thư viện quản lý bộ nhớ và dễ dẫn đến dừng chương trình.

### 4.7. Gọi hàm free\(\) không đúng

\_ **Invalid free**.

\_ Truyền vào các tham số không phải kết quả của hàm malloc\(\)

## 5. Các hỗ trợ của HĐH:

\_ Các hàm malloc\(\) và free\(\) không phải là lời gọi hệ thống mà là lời gọi từ các thư viện, được xây dựng dựa trên các lời gọi hệ thống.

\_ Một lời gọi hệ thống là _brk_ thay đổi địa điểm break của chương trình: vị trí của kết thúc bộ nhớ heap. Tăng giảm bộ nhớ của vùng nhớ heap.

\_ _mmap\(\)_ lấy bộ nhớ từ hệ điều hành _**.**_ 



