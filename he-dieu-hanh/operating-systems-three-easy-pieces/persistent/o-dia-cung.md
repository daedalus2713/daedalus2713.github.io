# Ổ đĩa cứng

## 1. Interface

\_ Mỗi một ổ cứng bao gồm nhiều **sectors**

* Mỗi sector ~512 bytes block
* Sector được đánh số thứ tự từ 0 - địa chỉ bộ nhớ
* Coi như 1 dãy các sector

\_ Mỗi lần cập nhật ổ đĩa, chỉ có thể thực hiện **atomic** trên 1 block.

## 2. Cấu trúc cơ bản

\_ Một **platter** \(đĩa\) - một vật thể cứng hình tròn, được dùng để lưu trữ dữ liệu dựa vào các thay đổi từ tính.

\_ Mỗi platter bao gồm 2 surface \(2 mặt đĩa\)

\_ Các platter được gắn với một motor gọi là **spindle** tại tâm, để quay các đĩa với tốc độ cố định RPM \(_Rotations per minutes - RPM_\)

\_ Dữ liệu được lưu trữ trên các đường tròn đồng tâm gọi là **track**.

\_ Để có thể đọc và ghi dữ liệu:

* Đầu đọc - disk head: có 1 disk head/1 surface, dùng để đọc hoặc thay đổi từ tính của đĩa
* Tay đọc - disk arm: các disk head được gắn vào disk arm để có thể di chuyển trong surface.

![](../../../.gitbook/assets/image%20%287%29.png)

## 3. Ổ đĩa cứng đơn giản

\_ Thời gian trễ của 1 track - Thời gian trễ khi quay: Thời gian cần phải chờ để quay sector đến dưới disk head.

\_ Nhiều track - thời gian tìm kiếm \(seek time\):

* **Seek**: đưa disk arm tới track cần đọc
  * Tăng tốc: bắt đầu di chuyển disk arm
  * Trượt - **coasting**: disk arm di chuyển ở tốc độ nhanh nhất
  * Giảm tốc: disk arm chậm lại
  * Settling: đặt disk arm vào track cần thiết

\_ Để có thể đưa đầu đọc tới đúng sector, cần phải di chuyển cả disk arm lẫn quay các platter.

\_ Track skew: Hỗ trợ các lệnh đọc tuần tự khi các sector được sắp xếp trên nhiều track  
=&gt; Giảm thời gian chờ đợi

\_ Multi-zoned disk drives

* Các track ở ngoài sẽ có nhiều sector hơn các track ở trong
* Disk được chia thành các zone, với mỗi zone có số lượng sector trên 1 track bằng nhau
* Các zones bên ngoài sẽ có nhiều sector hơn các zones bên trong.

\_ Track buffer:

* Dùng để lưu dữ liệu khi đọc hoặc ghi xuống đĩa
* Write  back/write through: thông báo I/O đã hoàn thành khi dữ liệu được lưu trong cache
  * Không đảm bảo tính đúng đắn của dữ liệu

## 4. I/O time

```text
T(I/O) = T(seek) + T(rotation) + T(transfer)
```

\_ Các yêu cầu thực thi tuần tự sẽ nhanh hơn nhiều lần so với các yêu cầu đọc/ghi ngẫu nhiên 

\_ Thời gian tìm kiếm trung bình được tính dựa trên khoảng cách tìm kiếm trung bình ~ N/3 \(N: số sectors\)

## 5. Lập lịch cho đĩa

\_ Thời gian tìm kiếm ngắn nhất:

* Sắp xếp hàng đợi theo các track
* Lựa chọn yêu cầu thuộc track gần với disk head hiện tại nhất
* Khó khăn
  * HĐH không nhìn được cấu trúc đĩa
  * HĐH sẽ chọn block nào có địa chỉ gần nhất
  * Starvation: các yêu cầu thuộc track xa sẽ phải đợi trong thời gian dài

\_ Thuật toán thang máy \(SCAN\)

* Sweep: 1 lần disk head đi từ track trong ra ngoài hoặc ngược lại
* Nếu yêu cầu thuộc cùng track đã được quét trong 1 sweep thì sẽ được sắp xếp cho sweep tiếp theo
* C-SCAN:
  * Chỉ sweep từ ngoài vào trong, và sẽ reset tại track ngoài cùng
  * Công bằng hơn 
* Thuật toán thang máy: Chỉ phục vụ đi theo 1 hướng nahát định
* Bỏ qua thời gian rotation trong tính toán

\_ Thời gian truy cập ngắn nhất:

* Lựa chọn phụ thuộc vào so sánh thời gian seek và thời gian rotation
* Khó khăn khi cài đặt trong HĐH, nên thường được đưa vào ngay trong các ổ đĩa cứng.

\_ Các khó khăn

* Lựa chọn  nơi thực hiện việc lập lịch
  * Các ổ đĩa hiện nay đã được tích hợp thêm các bộ lập lịch vào bên trong chúng
  * HĐH máy tính cũng sẽ lựa chọn các yêu cầu mà nó cho là tối ưu
* I/O merging:
  * Gộp các request trong các sector gần nhau lại thành 1, tại tầng **HĐH** 
  * Giảm thời gian tìm kiếm
  * Tăng thời gian chờ
* Thời gian chờ của I/O:
  * Work-conserving: Thực hiện ngay khi có yêu cầu
  * Non-work-conserving: Đợi 1 khoảng thời gian để thực thi các yêu cầu
    * Nghiên cứu chỉ ra thường sẽ có các request tối ưu hơn sau 1 khoảng thời gian chờ



