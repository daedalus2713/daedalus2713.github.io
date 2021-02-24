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
T(quay vòng) = T(hoàn thành) - T(tới)
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

## 6. Thời gian phản hồi

\_ Để đánh giá các hệ thống chia sẻ thời gian, một độ đo mới được xét đến là thời gian phản hồi. Đó là thời gian từ khi job đến cho tới lần đầu tiên job được lập lịch \(chạy lần đầu tiên\)

$$
T(phản hồi) = T (chạy lần đầu tiên) - T(đến)
$$

\_ Xét tới độ đo này, STCF và các chiến lược tương tự thường không cho thấy kết quả tốt. Vì 1 job sẽ phải đợi các job còn lại chạy xong để có thể thực hiện phản hồi.

