# Cơ chế: Chuyển đổi địa chỉ

Hai trong các mục tiêu chính của hệ điều hành là **hiệu quả** và **kiểm soát**.

* Hiệu quả: Sử dụng các hỗ trộ từ phần cứng
* Kiểm soát: Các chương trình chỉ được truy cập vào bộ nhớ của chính mình
* _Linh động_: Các chương trình có thể tùy ý sử dụng không gian nhớ của mình

Hệ điều hành và phần cứng cần phải cùng phối hợp làm việc để thực hiện cơ chế chuyển đổi địa chỉ:

* Phân cứng: Chuyển đổi từ địa chỉ ảo thành địa chỉ vật lý trong bộ nhớ
* Hệ điều hành: Quản lý các vùng nhớ

### 1. Giả định:

\_ Đơn giản hóa việc ảo hóa bộ nhớ

\_ Không gian bộ nhớ ảo của người dùng là _liên tục_ trong bộ nhớ vật lý.

\_ Không gian bộ nhớ ảo _nhỏ hơn_ không gian bộ nhớ vật lý.

\_ Mỗi không gian địa chỉ có kích thước _chính xác_.

### 2. Dynamic \(Hardware-based\) Relocation

\_ Một trong ý tưởng đầu tiên được đề cập là **base and bounds** \(Cơ sở và cận\) hay còn được gọi là dynamic relocation. Được áp dụng để có thể đặt các không gian địa chỉ **theo ý muốn** của người dùng và **giới hạn** tiến trình truy cập vào vùng nhớ của chúng. 

\_ Khi chương trình chạy, HĐH sẽ quyết định vùng nhớ vật lý nào sẽ được tải và đặt giá trị thanh ghi base. Từ đó, để truy cập được đến vùng nhớ vật lý, ta có công thức:  
_địa chỉ vật lý = địa chỉ ảo + base_

_\__ Thanh ghi bound được sử dụng để giới hạn lại vùng nhớ của tiến trình. Tất cả các địa chỉ ảo lớn hơn bound hoặc mang giá trị âm đều được coi là **không hợp lệ**.

 \_ Các cặp thanh ghi base & bounds là một phần cứng được đặt trong mỗi CPU \(Mỗi cặp/CPU\). Thường được gọi là bộ phận quản lý bộ nhớ \(Memory Management Unit\).

\_ HĐH cũng cần phải lưu lại các vùng nhớ trống, một trong các cách đơn giản là sử dụng danh sách vùng nhớ trống, là các vùng nhớ vật lý đang không được sử dụng.

### 3. Vấn đề của hệ điều hành

\_ HĐH cần phải tìm vùng nhớ trống để cấp phát cho chương trình mới được tạo ra

\_ Khi một tiến trình bị hủy bỏ, cần phải lấy lại các vùng nhớ của tiến trình đó \(cho lại vào free list\)

\_ Lưu trữ và tải lại các giá trị base & bound khi thực hiện context switch giữa các tiến trình, thường được lưu vào trong PCB. Hơn nữa, khi một tiến trình bị dừng, HĐH có thể di chuyển vùng nhớ của tiến trình bằng cách copy các giá trị sang vùng nhớ mới và cập nhật giá trị base.

\_ HĐH cần cài đặt các bộ xử lý ngoại lệ để bảo vệ bộ nhớ.

