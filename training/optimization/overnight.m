acc=zeros(14,102);
i=1;
for log2c = -1:8,
  for log2g = -4:-1,
      disp(log2c);
      disp(log2g);
    generateModels(log2c,log2g);
    ans=calcAccForAll;
    acc(3:14,i) = ans;
    acc(1,i) = 2^log2c;
    acc(2,i) = 2^log2g;
    i=i+1;
  end
end
save('overnight.mat','acc');