# Các dạng giải thuật

## Quay lui

\_ Tư tưởng: Sinh ra toàn bộ các nghiệm có thể và kiểm tra xem có đúng với yêu cầu đề bài không

```text
// Si: tap cac phan tu thu i
Procedure Backtrack(i);
begin
    < Xac dinh Si >;
    for xi in Si do 
    begin
        < ghi nhan thanh phan thu i >;
        if (tim thay nghiem) then < Dua ra nghiem >
        else Backtrack(i+1);
        < Loai thanh phan thu i >
    end;
end;
```

## Nhánh cận

\_ Tư tưởng: Giống với quay lui, tuy nhiên có sử dụng một hàm f\(x\) để xác định độ tốt để xác định nghiệm của bài toán và cần tìm nghiệm sau cho hàm f\(x\) cho kết quả tốt nhất:

* Nếu tìm được nghiệm tốt hơn: cập nhật f\(x\)
* Tìm được nghiệm có độ tốt kém hơn: không cần mở rộng tập nghiệm

```text
Procedure BranchBound(i);
begin
    < danh gia cac nghiem mo rong >;
    if ( nghiem mo rong khong toi hon BestSolution) then exit;
    < Xac dinh Si >;
    for xi in Si do
    begin
        < ghi nhan thanh phan thu i >;
        if (tim thay nghiem) then < cap nhat BestSolution > else BranchBound(i+1);
        < loai thanh phan i >;
    end;
end;
```

## Tham lam

\_ Tư tưởng: 

* Xây dựng tập nghiệm từng bước
* Khi mở rộng tập nghiệm, chọn ra xi tốt nhất để thêm vào tập nghiệm
* **Lưu ý: có thể chỉ tìm được nghiệm gần đúng với nghiệm tối ưu**

```text
Procedure Greedy;
begin
    X := nil;
    i := 0;
    while (chua xay dung xong het thanh phan cua nghiem) do
    begin
        i := i + 1;
        < Xac dinh Si >;
        X <- selectBest(Si);
    end;
end;    
```

## Chia để trị

\_ Tư tưởng: Phân bài toán cần giải thành các bài toán con, cho đến khi ta nhận được bài toán con hoặc đã có thuật giải hoặc có thể dễ dàng đưa ra thuật giải, sau đó kết hợp các nghiệm. Các bài toán con:

* Thường là cùng dạng với bài toán ban đầu
* Có cỡ nhỏ hơn 

```text
procedure DivideConquer(A,x);
begin
    if (A du nho) then Solve(A)
    else
    begin
        Chia A thanh cac ban toan con A1, A2,...., Am;
        for i := 1 to m do DivideConquer(Ai,xi);
        Ket hop cac nghiem xi (i= 1 -> m) cua cac bai toan Ai de 
        tim duoc nghiem cua bai toan A;
    end;
end;
```

## Quy hoạch động

Tư tưởng bài toán: 

* Chia bài toán cần giải thành các bài toán con có thể giải được dễ dàng
* Sử dụng 1 bảng để lưu giữ lời giải của các bài toán con đã được giải
* Lấy lời giải ở trong bảng để tổng hợp lại thành lời giải cho bài toán ban đầu

Các bước giải bài toán:

* Tìm nghiệm của bài toán con nhỏ nahát
* Tìm ra công thức xây dựng nghiệm của bài toán qua các bài toán cỡ nhỏ hơn
* Tạo ra một bảng lưu giữ các nghiệm của bài toán con
* Tìm nghiệm của bài toán ban đầu

