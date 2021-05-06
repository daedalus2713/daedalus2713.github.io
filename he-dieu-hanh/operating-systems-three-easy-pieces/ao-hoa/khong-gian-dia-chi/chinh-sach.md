# Chính sách

## 1. Quản lý cache

\_ Cache: giữ một tập hợp con của các trang trong hệ thống.

\_ Mục đích: tăng số lần cache hits \(giảm cache misses\)

\_ Average memory access time:  
AMAT = \(time to access memory\) + \(\(probability of miss\)\*\(time to access disk\)\)

\_ Vì chi phí truy cập tới đĩa rất lớn nên chỉ cần thay đổi tỉ lệ miss có thể dẫn tới thay đổi lớn trên tổng thời gian

## 2. Chính sách thay thế tối ưu

\_ Tư tưởng: Thay thế trang sẽ được truy cập trong thời gian xa nhất.

\_ Không thực tế vì không thể xác định được thời gian tiếp theo trang được truy cập. Tuy nhiên có thể được dùng làm thước đo để so sánh tính tối ưu của các phương pháp khác.

{% hint style="info" %}
**Các loại cache miss:**

**+ Cold-start miss**: Cache bị miss khi chương trình mới bắt đầu \(cache rỗng\)

**+ Capacity miss:**  Miss vì giới hạn bộ nhớ của cache

**+ Conflict miss:** Liên quan tới phần cứng, giới hạn về việc lưu trữ trên phần cứng cache
{% endhint %}

## **3. FIFO: đơn giản**

\_ Đảm bảo tính đơn giản: đưa page ở cuối ra khi thêm page ở đầu vào.

\_ Không xác định được tính quan trọng của các block, nên dễ dẫn tới việc các trang thường xuyên được truy cập vẫn bị loại khỏi cache.

## **4. Ngẫu nhiên**

\_ Ngẫu nhiên: đơn giản để hiểu cơ chế cũng như cài đặt.

\_ Chọn một trang bất kỳ để loại ra khỏi cache.

\_ Phụ thuộc vào may mắn để xác định tỉ lệ cache miss/hit

## 5. Least recently used - LRU

\_ Tư tưởng: Phụ thuộc vào lịch sử truy cập để dự đoán trong tương lai.

\_ Một yếu tố để xét đến là tần suất: nếu một trang có tần suất truy cập cao thì không nên bị thay thế.

### 5.1. Thuật toán xét lịch sử

\_ Mỗi khi có một lượt truy cập, ta cần cập nhật để đưa trang đó lên đầu tiên. Và như vậy cần phải theo dõi mỗi lần truy cập vào cache từ hệ thống   
=&gt; Dễ dẫn đến chi phí cao làm giảm hiệu năng hệ thống

\_ Bổ sung thêm sự hỗ trợ về phần cứng, khi trang được truy cập, có thể đặt giá trị cho **trường thời gian** và sau đó chỉ cần tìm tới trang có thời gian truy cập xa nhất để loại bỏ.

### 5.2. LRU xấp xỉ

\_ Thêm một bit là use bit \(hoặc reference bit\) cho mỗi trang trong hệ thống. Mỗi khi trang được truy cập, bit này sẽ được chuyển thành 1 và việc thay đổi về 0 sẽ do HĐH thực hiện.

\_ Áp dụng thuật toán đồng hồ trên danh sách liên kết vòng. Khi cần thực hiện thay thế trang

* Duyệt tuần tự các trang,
* Nếu thấy use bit = 1, chuyển về 0, tới trang tiếp theo
* Nếu thấy use bit = 0, loại bỏ trang đó, lưu lại vị trí để tiếp tục vòng lặp sau

## 6. Dirty pages

\_ Dirty page: Trang đang ở trong bộ nhớ chính/cache, đã được chỉnh sửa nhưng phần chỉnh sửa chưa được lưu lại vào bộ nhớ dài hạn.

\_ Dùng thêm 1 bit **modified bit** để kiểm tra xem page đã được chỉnh sửa hay chưa. 

## 7. Chính sách VM khác

\_ Chọn trang để di chuyển giữa các bộ nhớ:

* Theo nhu cầu: khi một trang được yêu cầu thì mới di chuyển
* Dự đoán: Có thể lấy trước một số trang mà HĐH nghĩ rằng sẽ tiếp tục được sử dụng

\_ Việc di chuyển một số lượng lớn trang trong 1 yêu cầu làm giảm chi phí đọc/ghi. Thường được gọi là **clustering/grouping.** 

## 8. Thrashing

\_ Khi bộ nhớ bị yêu cầu quá mức, lớn hơn so với phần bộ nhớ hiện có -&gt; hệ thống liên tục phải di chuyển các trang.

\_ HĐH thường xử lý bằng cách tạm dừng hoặc dừng hẳn một tập các tiến trình.

\_ Tuy nhiên, cần phải quản lý các tiến trình bị dừng vì nếu dừng các tiến trình quan trọng để phục vụ cho việc quản lý của hệ thống, hay của HĐH sẽ dẫn tới các lỗi khó khắc phục.

