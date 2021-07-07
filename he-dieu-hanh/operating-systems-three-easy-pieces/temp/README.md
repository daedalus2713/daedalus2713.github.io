# Đồng thời

## 1.**Luồng**: 

\_ Chương trình đa luồng là chương trình có nhiều hơn một điểm thực thi \(execution points\)

\_ Gần giống với tiến trình

\_ Các luồng trong cùng 1 chương trình có chung không gian địa chỉ

\_ Khi thực hiện context-switch sẽ cập nhật như context-switch của tiến trình, tuy nhiên giữ nguyên không gian địa chỉ

\_ Sử dụng **Thread Control Block** để lưu trữ và điểu khiển luồng

\_ Vùng nhớ **stack** của luồng sẽ được lưu trong không gian địa chỉ của tiến trình, tuy nhiên không gây ra hết bộ nhớ vì dung lượng thường nhỏ.

## 2. Song song

\_ Ưu thế của việc chạy song song:

* Chia nhỏ công việc và thực hiện cùng lúc để tăng tốc thời gian tính toán
* Giảm thiểu thời gian tiến trình bị block do các hoạt động I/O

\_ Thực hiện đa tiến trình có thể sử dụng thay cho đa luồng, tuy nhiên nên dùng cho các nhiệm vụ độc lập và chỉ chia sẻ rất ít thông tin với nhau.

## 3. Chia sẻ thông tin

\_ Chia sẻ một thông tin chung giữa các tiến trình có thể làm mất đi tính đúng đắn của thông tin đó.

### 3.1. Lập lịch không kiểm soát

\_ Do trình tự chạy của các luồng và các chỉ dẫn do bộ lập lịch tự quyết định nên không thể đảm bảo được các luồng chạy đúng theo thứ tự mong muốn \(mà không có các biện pháp hỗ trợ\)

\_ **Race condition**: Kết quả dựa trên thời gian thực hiện của mã lệnh. 

\_ Tài nguyên được chia sẻ giữa các luồng được gọi là tài nguyên găng \(**critical section**\)

### 3.2. Tính nguyên tử \(atomicity\)

\_ Cần phải đảm bảo một số chỉ dẫn được thực hiện theo trình tự bắt buộc

\_ Tính nguyên tử: Như một khối ~ tất cả hoặc không có gì

### 3.3. Chờ đợi giữa các luồng

\_ Khi hỗ trợ tính nguyên tử, thì các luồng sử dụng tài nguyên găng cần phải chờ đợi để có thể thực hiện

