% create lift and drag polar surfaces

s1 = load('jacobs_CL.mat'); % load in all jacobs data above Re = 1e6
varNames = fields(s1);
jacobs_re = [];
jacobs_a = [];
jacobs_CL = [];
for i = 1:length(fields(s1))
    jacobs_re_temp = get_fname_val(varNames{i},'CL');
    if jacobs_re_temp>1000
        jacobs_CL = [jacobs_CL; s1.(varNames{i})(:,2)];
        jacobs_a = [jacobs_a; s1.(varNames{i})(:,1)];
        jacobs_re = [jacobs_re; ones(numel(s1.(varNames{i})(:,1)),1).*jacobs_re_temp];
    end
end
jacobs_re = jacobs_re.*1000;
%%
s1 = load('timmer_CL.mat'); % load in all timmer data
varNames = fields(s1);
timmer_re = [];
timmer_a = [];
timmer_CL = [];
for i = 1:length(fields(s1))
    if varNames{i}(end)~='d'
        timmer_re_temp = get_fname_val(varNames{i},'CL');
        
        timmer_CL = [timmer_CL; s1.(varNames{i})(:,2)];
        timmer_a = [timmer_a; s1.(varNames{i})(:,1)];
        timmer_re = [timmer_re; ones(numel(s1.(varNames{i})(:,1)),1).*timmer_re_temp];
    end
end
timmer_re = timmer_re.*1000;
%%
load('sheldahl')

sheldahl_CL = reshape(sheldahl_CL,numel(sheldahl_CL),1);
[sre,sa] = meshgrid(sheldahl_re,sheldahl_alpha);
sheldahl_re = reshape(sre,numel(sre),1);
sheldahl_alpha = reshape(sa,numel(sa),1);

% get rid of values below 32 deg , except the highest reynolds num
sh_re = sheldahl_re;
sh_a = sheldahl_alpha;
sheldahl_alpha(sh_a<32 & sh_re < 4e6) = [];
sheldahl_re(sh_a<32 & sh_re < 4e6) = [];
sheldahl_CL(sh_a<32 & sh_re < 4e6) = [];

%% Combine

re = [sheldahl_re; timmer_re; jacobs_re];
alpha = [sheldahl_alpha; timmer_a; jacobs_a];
CL = [sheldahl_CL; timmer_CL; jacobs_CL];
