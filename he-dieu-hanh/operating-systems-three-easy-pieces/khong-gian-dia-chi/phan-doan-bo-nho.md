---
description: Segmentation
---

# Phân đoạn bộ nhớ

## 1. Áp dụng rộng rãi Base/Bounds

\_ Tạo một cặp base/bounds cho mỗi phân đoạn logic.

\_ Mỗi segment là một vùng nhớ liên tiếp trong không gian địa chỉ với độ dài cụ thể.

\_ Áp dụng phân đoạn sẽ giúp cho OS cấp cho các tiến trình 3 phân đoạn logic khác nhau: code, heap, stack mà không bị lãng phí bộ nhớ ở giữa heap và stack.

## 2. Cách phân biệt các phân đoạn

\_ HĐH sẽ lấy bớt các bit trong không gian bộ nhớ để chỉ định vùng nhớ segment. Địa chỉ được chia làm 2 phần: các bit phân biệt phân đoạn & _offset_. Offset cũng cần được đảm bảo xem có nhỏ hơn bounds không để tránh các truy cập bộ nhớ không hợp lệ.

\_ Một số hệ thống có thể gộp chung phân đoạn code và heap làm 1 để chỉ cần dùng 1 bit để chọn.

\_ Cũng có thể ngầm định phân đoạn bằng cách xem địa chỉ được tạo ra như thế nào:

* Sinh ra từ program counter: code
* Dựa vào stack hoặc con trỏ: stack
* Còn lại: heap

### 2.1. Stack

\_ Vùng nhớ stack mở rộng theo hướng ngược với các vùng nhớ khác. Cho nên cần phải thông báo cho phần cứng cách mở rộng vùng nhớ để xác định địa chỉ vật lý.

\_ Công thức:   
_physical address = offset - maxSegmentSize + base_ 

## 3. Hỗ trợ chia sẻ bộ nhớ

\_ Thêm bit bảo vệ để phân biệt quyền của các tiến trình lên phân đoạn đó \(đọc, ghi, thực thi\).

\_ Nếu để là chỉ đọc thì phân đoạn này có thể được chia sẻ giữa các tiến trình.

## 4. Hỗ trợ từ HĐH

\_ Để quản lý bộ nhớ tốt hơn, cần sự hỗ trợ từ phần cứng như **bảng phân đoạn**. Giúp cho ta quản lý một số lượng lớn các phân đoạn để tối ưu hóa bộ nhớ chính, tuy nhiên, trình dịch cần chia nhỏ các phân đoạn bộ nhớ để phù hợp với dung lượng phân đoạn của hệ thống.

\_ HĐH cần lưu trữ và khôi phục các thanh ghi hỗ trợ việc quản lý phân đoạn để hỗ trợ context switch.

\_ HĐH cần quản lý các vùng nhớ trống, các phân đoạn của từng tiến trình cũng như kích thước của chúng. Khi cấp phát có thể dẫn tới việc phân mảnh ngoài - **external fragmentation** \(Có nhiều vùng nhớ trống kích thước nhỏ dẫn tới khó khăn khi cấp phát bộ nhớ\).

* Một giải pháp là sắp xếp lại các phân đoạn để dành nhiều vùng nhớ trống hơn, tuy nhiên việc này dẫn tới chi phí lớn khi sao chép, di chuyển và dừng tiến trình để sắp xếp.
* Cách khác là dùng các thuật toán cấp phát vùng nhớ như: best fit, first fit, worst fit,...

