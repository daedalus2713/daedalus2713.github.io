# Quản lý vùng nhớ trống

**Paging** \(phân trang\): Chia vùng nhớ thành các phần tử có kích thước cố định, lưu trữ danh sách các phần tử đó, trả về điểm truy cập đầu tiên \(địa chỉ đầu tiên\) khi có yêu cầu cấp phát.

**Phân mảnh ngoài**: Bộ nhớ bị chia thành các vùng nhớ trống kích thước nhỏ, không tồn tại đủ không gian nhớ trống liên tiếp để cấp phát theo yêu cầu mặc dù tổng bộ nhớ trống thỏa mãn.

## 1. Giả định

\_ Có các interface đơn giản để quản lý bộ nhớ

* malloc\(size\_t size\): Truyền vào độ lớn của vùng nhớ và trả về con trỏ tới vùng nhớ đó
* free\(void \*ptr\): Truyền vào con trỏ quản lý vùng nhớ và giải phóng vùng nhớ đó
* Thư viện cần phải có khả năng quản lý kích thước của các vùng nhớ vì chỉ có truyền con trỏ tới vùng nhớ trong chương trình
* Vùng nhớ mà thư viện quản lý được gọi là **heap** và giả định tồn tại một cấu trúc dữ liệu quản lý vùng nhớ trống

\_ Chỉ quan tâm tới việc phân mảnh ngoài hơn là phân mảnh trong.

\_ Vùng nhớ khi đưa được cấp phát sẽ không bị di chuyển sang vị trí khác trong bộ nhớ, nên không thể nén bộ nhớ để giảm thiểu phân mảnh.

\_ Bộ cấp phát quản lý một vùng liên tiếp các bytes liên tiếp, mặc dù bộ cấp phát có thể yêu cầu mở rộng vùng nhớ nhưng để đơn giản ta giả định rằng các vùng nhớ có kích thước cố định.

## 2. Cơ chế ở tầng thấp \(low-level\)

### 2.1. Phân chia và hợp nhất

\_ Danh sách vùng nhớ trống được biểu diễn ở dạng danh sách liên kết, bao gồm mỗi phần tử chứa giá trị về địa chỉ đầu tiên của vùng nhớ và độ dài của nó.

\_ **Phân chia**: Khi có yêu cầu cấp phát bộ nhớ, bộ cấp phát sẽ tìm một vùng nhớ có độ dài đủ lớn và chia nó ra làm 2, một phần với kích thước yêu cầu sẽ được trả cho lời gọi hàm, phần còn lại \(với địa chỉ đầu hoặc độ dài thay đổi\) sẽ được giữ lại trong danh sách trống.

\_ Khi vùng nhớ được giải phóng, thì sẽ một phần tử mới sẽ được tạo ra và đưa vào đầu danh sách trống. Tuy nhiên cách này sẽ dẫn tới bộ nhớ phân mảnh khi các phần tử trong danh sách sẽ không có đủ độ dài để cấp phát cho các yêu cầu dù thực tế tổng bộ nhớ trống là đủ.

\_ **Hợp nhất**: Khi một vùng nhớ trống được trả lại, bộ cấp phát sẽ tìm kiếm địa chỉ của vùng nhớ đó và hợp nhất với các vùng nhớ trống liền kề có sẵn trong danh sách.

### 2.2. Theo dõi kích thước của các vùng nhớ đã cấp phát

\_ Để thư viện có thể theo dõi kích thước vùng nhớ đã cấp phát, bộ cấp phát dùng một không gian nhỏ ở đầu mỗi vùng nhớ để lưu trữ thông tin đó, hay còn gọi là các **header**. Thường bao gồm các thông tin:

* Kích thước vùng nhớ đã cấp phát
* Một số con trỏ khác để hỗ trợ việc giải phóng
* Một số **magic** phục vụ kiểm tra tính toàn vẹn
* Các thông tin khác...

\_ Bây giờ kích thước các vùng nhớ trên thực tế sẽ bao gồm cả kích thước của các header.

### 2.3. Tự cài đặt danh sách trống

\_ Tự xây dựng ở bên trong vùng nhớ trống

\_ Khi vùng nhớ hoàn toàn trống \(được trả về khi gọi lời gọi hệ thống **mmap\(\)**\), một con trỏ head sẽ được tạo ra để chỉ địa chỉ bắt đầu của vùng nhớ đó, giá trị next bằng 0.

\_ Khi có yêu cầu cấp phát, bộ nhớ đó được chia làm 2 phần

* Phần đầu: 
  * Kích thước: yêu cầu + header
  * Con trỏ chỉ tới địa chỉ của vùng nhớ cấp phát
* Phần sau:
  * Con trỏ head chỉ tới vùng nhớ trống
  * Header của vùng nhớ được thay đổi \(kích thước\)
  * Con trỏ head cũng được di chuyển tới điểm đầu tiên của vùng nhớ trống

\_ Khi một vùng nhớ được trả lại, nếu nó nằm giữa các vùng nhớ đã được cấp phát, thì giá trị next trong header của vùng nhớ trống đó sẽ chỉ tới địa chỉ của vùng nhớ trống tiếp theo trong bộ nhớ.

\_ Áp dụng kỹ thuật hợp nhất mỗi khi một vùng nhớ được trả về để đảm bảo tồn tại vùng nhớ trống liên tiếp lớn nhất cho lần cấp phát tiếp theo.

### 2.4. Tăng kích thước vùng nhớ heap

\_ Thường khi vùng nhớ heap bị hết, các yêu cầu cấp phát sẽ thất bại.

\_ Thường các bộ cấp phát sẽ bắt đầu với vùng nhớ heap nhỏ và yêu cầu HĐH tăng dần theo thời gian, HĐH sẽ tìm các trang vật lý và ánh xạ chúng tới không gian địa chỉ, trả về giá trị cuối cùng của vùng nhớ heap mới

## 3. Các chiến lược cấp phát cơ bản

### 3.1. Best fit

\_ Tìm kiếm toàn bộ free list

\_ Trả về vùng nhớ có kích thước nhỏ nhất mà phù hợp với yêu cầu

\_ Giảm thiểu bộ nhớ thừa

\_ Tốn thời gian tìm kiếm và tính toán

### 3.2. Worst fit

\_ Ngược lại với best fit

\_ Giữ lại các vùng nhớ lớn hơn là nhiều vùng nhớ nhỏ

\_ Yêu cầu thời gian tính toán lớn

\_ Nghiên cứu cho thấy hiệu quả thấp, thường dẫn tới phân mảnh dù tốn nhiều thời gian tính toán

### 3.3. First fit

\_ Vùng nhớ đầu tiên đủ để cấp phát cho yêu cầu

\_ Thời gian xử lý nhanh

\_ Dễ dẫn tới việc là phần đầu của danh sách trống sẽ bao gồm các phần tử với kích thước nhỏ.

\_ Có thể sử dụng **sắp xếp địa chỉ** để tối ưu cho việc hợp nhất bộ nhớ, giảm thiểu phân mảnh.

### 3.4. Next fit

\_ Thêm một con trỏ chỉ tới vùng nhớ được tìm kiếm cuối cùng. Tiếp tục tìm kiếm vùng nhớ phù hợp từ vị trí đó.

\_ Lan tỏa việc tìm kiếm giữa các vùng nhớ.

\_ Tránh được việc thời gian tính toán kéo dài.

## 4. Các cách tiếp cận khác

### 4.1. Danh sách tách biệt

\_ Giả sử các chương trình thông thường sẽ hay yêu cầu một vùng nhớ với kích thước cố định, tạo ra một danh sách quản lý các đối tượng với kích thước cố định, các yêu cầu với kích thước khác sẽ được chuyển cho bộ cấp phát chung.

\_ Khi có các vùng nhớ chuyên phục vụ cho kích thước cố định, các yêu cầu cấp phát và giải phóng thường nhanh hơn nếu kích thước trùng với yêu cầu.

\_ Thường sử dụng cho các đối tượng của kernel

* Cấp phát các vùng nhớ gọi là **object caches** 
* Khi vùng nhớ caches bị đầy, sẽ yêu cầu thêm từ bộ cấp phát chung
* Khi vùng nhớ caches trống nhiều, bộ cấp phát chung có thể lấy lại các vùng nhớ đó

### 4.2. Buddy allocation

\_ Quan trọng hóa việc hợp nhất các nhớ.

\_ Coi vùng nhớ có kích thước 2^n, với mỗi yêu cầu cấp phát, sẽ chia vùng nhớ trống thành 2 nửa bằng nhau cho tới khi có vùng nhớ đủ lớn.

\_ Có thể dẫn tới phân mảnh trong.

\_ Dễ dàng cho việc hợp nhất các vùng nhớ, chỉ cần nối với vùng nhớ liền kề bên cạnh có cùng kích thước.

\_ Có thể dễ dàng đánh địa chỉ các vùng nhớ vì một cặp buddy chỉ khác nhau 1 bit.

