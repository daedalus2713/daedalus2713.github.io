# Semaphores

## 1. Định nghĩa

\_ Là 1 CTDL với 1 biến integer mà chúng ta có thể điều chỉnh bởi 2 luồng.

\_ Giá trị khởi tạo của Semaphore nhằm xác định các hành vi của nó.

\_ Tương tác với semaphore:

* sem\_wait\(\): giảm giá trị đi 1 đơn vị hoặc đợi nếu giá trị của semaphore âm
* sem\_post\(\): tăng giá trị của semaphore lên 1 đơn vị, gọi dậy các luồng đang chờ

\_ Giá trị âm của semaphore thể hiện số luồng đang đợi 

## 2. Khóa - Semaphore nhị phân

\_ Giá trị khởi tạo của semaphore = 1

\_ Luồng thực hiện

* sem\_wait\(\) được gọi trước
* Giá trị của semaphore được chuyển về 0
* Thực hiện công việc trong đoạn găng
* Gọi sem\_post\(\)
  * Nếu không có luồng nào khác đã gọi sem\_wait\(\) -&gt; giá trị được chuyển về 1
  * Nếu đã có luồng khác gọi sem\_wait\(\)
    * Giá trị của semaphore -1 -&gt; 0
    * Luồng đang đợi được gọi dậy và thực hiện trong đoạn găng
    * Sau khi thực hiện xong, sem\_wait\(\) được gọi và tăng giá trị semaphore về 1

## 3. Semaphore đảm bảo thứ tự

\_ Coi như 1 condition variable

\_ Sử dụng khi một luồng cần phải đợi cho tới khi một luồng khác được thực hiện xong

\_ Ví dụ

* 1 luồng tạo luồng con và đợi cho luồng con chạy xong mới return
* Giá trị semaphore được khởi tạo là 0
* Khi tạo luồng con, luồng cha gọi sem\_wait\(\), 
  * sau khi xong luồng con gọi sem\_post\(\)
* TH1: sem\_wait\(\) được gọi trước
  * semaphore: 0 -&gt; -1
  * luồng cha vào trạng thái đợi
  * khi luồng con xong, sem\_post\(\) được gọi
    * semaphore: -1 -&gt; 0
    * Luồng cha được gọi dậy thực hiện
* TH2: sem\_post\(\) được gọi trước
  * semaphore: 0 -&gt; 1
  * khi sem\_wait\(\) được gọi
    * semaphore: 1 -&gt; 0
    * luồng cha được thực thi ngay lập tức

## 4. Buffer có giới hạn \(Producer/Consumer\)

\_ Cần có 2 semaphore để thông báo trạng thái của buffer: **empty** & **full.**

* empty = MAX buffer size
* full = 0

\_ Các hàm của buffer

* producer:
  * sem\_wait\(&empty\)
  * put\(\)
  * sem\_post\(&full\)
* consumer:
  * sem\_wait\(&full\)
  * get\(\)
  * sem\_post\(&empty\)

\_ Khi có nhiều producer và consumer:

* Cần đảm bảo cho chỉ có 1 luồng được truy cập buffer trong 1 thời điểm -&gt; **Mutex lock** \(binary semaphore\)

{% hint style="info" %}
Chỉ nên dùng mutex lock ngay trước và sau tài nguyên găng, không nên đưa các semaphore vào trong mutex lock vì sẽ dễ dẫn tới deadlock
{% endhint %}

## 5. Khóa Reader/Writer

\_ Khóa Read

* Cho phép nhiều luồng cùng được lấy khóa
* Lấy luôn cả semaphore **writelock** 

\_ Khóa Write:

* Chỉ cho phép duy nhất 1 luồng có thể lấy khóa
* Cần phải đợi cho semaphore **writelock = 0** &lt;=&gt; không còn reader nào đang đọc

\_ Vấn đề về tính công bằng, khi mà các reader có thể luôn luôn lấy khóa và để cho writer phải đợi. Dẫn tới tình trạng đói tài nguyên, writer có thể phải đợi vô hạn.

## 6. Dining Philosophers

{% hint style="info" %}
Cách giải quyết: Đổi thứ tự lấy dĩa của 1 philosopher bất kỳ, làm phá vỡ vòng đợi
{% endhint %}

## 7. Zemaphore - cài đặt semaphore

\_ Gồm 1 khóa, 1 biến điều kiện, 1 giá trị int

\_ Không duy trì giá trị âm của để thể hiện được số lượng các luồng đang đợi

\_ Giống với implementation của Linux



