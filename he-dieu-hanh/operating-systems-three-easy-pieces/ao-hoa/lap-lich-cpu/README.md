# Lập lịch CPU

## 1. Giả định workload

\_ Chúng ta đơn giản hóa bằng cách giả định các tiến tiến trình đang chạy trong hệ thống, đôi khi chúng được gọi là các **workload.**

\_ Chúng ta cũng giả định các tiến trình, đôi khi gọi là các **jobs**, mà đang chạy trong hệ thống:

* Mỗi job chạy trong khoảng thời gian bằng nhau
* Các jobs đến cùng 1 lúc
* Một khi đã khởi tạo, các jobs sẽ chạy tới khi hoàn thành
* Các jobs sẽ chỉ sử dụng CPU
* Biết được thời gian chạy của mỗi job

## 2. Độ đo lập lịch

\_ Thời gian quay vòng \(**turnaround time**\): tồng thời gian từ khi job đến cho tới khi hoàn thành. Thể hiện tính hiệu quả của việc lập lịch

$$
T(turnaround) = T(complete) - T(arrive)
$$

_\__ Độ công bằng cũng là một số liệu mà ta cần quan tâm tới.

## 3. FIFO - First in, first out

\_ Tuy 3 jobs đến cùng 1 lúc, nhưng ta giả định rằng các jobs sẽ đến lần lượt vì FIFO phải chọn được job để cho lên đầu.

\_ Nếu 3 jobs có thời gian thực hiện như nhau \(= t \) thì

$$
Tturnaround = (t + 2t + 3t)/3 = 2t
$$

\_ Tuy nhiên, nếu có một job chạy rất lâu so với các job khác, như vậy sẽ làm tăng thời gian quay vòng trung bình lên đáng kể. Vấn đề này thường được gọi là hiệu ứng đoàn xe \(**convoy effect**\), khi một số lượng các jobs tiêu thụ ít tài nguyên được xếp sau 1 job cần nhiều tài nguyên.

## 4. SJF - Shortest job first

\_ Giả định là sử dụng **bộ lập lịch không ưu tiên**

\_ Để giải quyết vấn đề của FIFO, ta có thể chạy tuần tự các job có thời gian thực thi ngắn nhất.

\_ Khi ta giả định rằng các job tới cùng 1 thời điểm, thì SJF cho thấy đó là thuật toán tối ưu nhất.

\_ Tuy nhiên, khi các job có thể tới tại bất cứ thời điểm nào, thì khi 1 job nặng A đang chạy, và các jobs nhẹ B, C trong thời gian đó, thì ta vẫn gặp phải hiệu ứng đoàn xe.

## 5. STCF - Shortest to completion first

\_ Khi thêm **bộ lập lịch có ưu tiên** vào SJF ta có STCF

\_ Khi A đang chạy và B, C tới; HĐH có thể dừng job A và chạy các job khác, sau đó mới tiếp tục chạy job A.

\_ HĐH sẽ quyết định xem job nào cần ít thời gian nhất để hoàn thành và thực hiện chạy job đó.

## 6. Độ đo: Thời gian phản hồi

\_ Để đánh giá các hệ thống chia sẻ thời gian, một độ đo mới được xét đến là thời gian phản hồi. Đó là thời gian từ khi job đến cho tới lần đầu tiên job được lập lịch \(chạy lần đầu tiên\)

$$
T(response) = T (first run) - T(arrive)
$$

\_ Xét tới độ đo này, STCF và các chiến lược tương tự thường không cho thấy kết quả tốt. Vì 1 job sẽ phải đợi các job còn lại chạy xong để có thể thực hiện phản hồi.

## 7. RR - Round robin

\_ Round robin chạy 1 job trong 1 khoảng thời gian \(**time slice/scheduling quatum**\) và chuyển sang một job khác trong hàng đợi để chạy.

\_ Thời gian phản hồi của hệ thống sẽ tỉ lệ nghịch với khoảng thời gian lập lịch lại của thuật toán. Tuy nhiên, nếu thời gian lập lịch quá ngắn thì chi phí để dành cho việc lập lịch sẽ tốn rất lớn. Cho nên ta cần cân đối thời gian để chi phí của việc lập lịch không làm cho hệ thống mất tính nhanh nhẹn.

\_ Chi phí của context switch không chỉ đến từ việc lưu và phục hồi các thanh ghi, ngoài ra còn từ việc chuyển trạng thái của CPU caches, TLBs\(Translation lookaside buffer\), dự đoán rẽ nhánh và các phần cứng khác. Context switch làm cho các trạng thái này bị mất đi và đưa vào các trạng thái mới của job đang chạy.

\_ Khi xét riêng về thời gian quay vòng, ta có thể thấy RR là một thuật toán tồi, vì nó gần như kéo dài job ra nhiều nhất có thể. Tuy nhiên, việc này sẽ đảm bảo được tính công bằng khi chạy các job.

## 8. Incorporating I/O

\_ Khi một tiến trình thực hiện thao tác I/O, nó sẽ ở trạng thái **blocked,** và không sử dụng CPU trong khoảng thời gian này. 

* Khi đó, bộ lập lịch có thể cho job khác chạy. 
* Khi I/O được thực hiện xong, 1 tín hiệu ngắt sẽ được gửi và HĐH đưa tiến trình trở lại trạng thái **ready.**

## 9. Không có dự đoán về thời gian chạy của job

\_ HĐH thường không thể biết hoặc có rất ít thông tin về độ dài của mỗi job. Vậy làm các này để ta có thể tiếp cận các phương pháp như SJF/STCF nếu không có thông tin? Hơn nữa là kết hợp các tư tưởng trong bộ lập lịch Round Robin để cải thiện thời gian phản hồi ?

