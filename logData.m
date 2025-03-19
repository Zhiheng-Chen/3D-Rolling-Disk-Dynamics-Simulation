function [data_t,data_Z] = logData(data_t,data_Z,t,Z)
for ii = 1:length(t)
    data_t(end+1) = t(ii);
    data_Z(end+1,:) = Z(ii,:);
end

end