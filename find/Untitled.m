A = [60,600,15,2];
C = [60,600,15,1];
B = [60,512,30,13];
% For each element of B find the indices of elements of A which are
% greater or equal:
D = cell(size(B));
for i = 1:numel(B)
  D( = find(C(i) <= A);
end
D