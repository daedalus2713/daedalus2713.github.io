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

## Tham ăn:

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

