function [ dom_freq, dom_amp] = FFT_data( time_data, N_zeropad, plot_flag)


%% [0] データの向きを調整
[row col] = size( time_data);
if row < col
    time_data = time_data.';
end

%% [1] 時刻歴・データ抽出
time_m = time_data(:,1);
data = time_data(:,2);
N_data = length( data);

%% [2] 周波数領域 [Hz]
t_samp = mean( diff( time_m));%% サンプリング周期 [s]
f_vec = (1:N_data)/N_data*t_samp^-1;%% 周波数領域 (サンプリング周波数の半分までが有効) [Hz]

if ~exist( 'N_zeropad', 'var') 
    N_zeropad = N_data; 
else     
    if N_zeropad < N_data
        N_zeropad = N_data;   
    else
        f_vec = (1:N_data)/N_data*t_samp^-1*N_data/N_zeropad;
    end
end

fft_data = fft( data, N_zeropad);



%% [3] 振幅スペクトル算出 [1]
amp = abs( fft_data/N_data);
amp = amp(1:floor( N_data/2)+1);            %% サンプリング周波数の半分の周波数領域が有効範囲: [ 0, fs/2] [Hz]
amp(2:end) = 2*amp(2:end);                  %% 負の周波数の分を足す．

f_vec2 = f_vec(1:length( amp));             %% サンプリング周波数の半分の周波数領域が有効範囲: [ 0, fs/2] [Hz]


%% [4] 卓越周波数の探索
[ dom_amp, idx_dom_amp] = max( amp);
dom_freq = f_vec2(idx_dom_amp);

%% [5] plot

if exist( 'plot_flag', 'var')

    figure(1000)


    semilogx( f_vec2, amp)
    xlabel('{\itf} [Hz]')
    ylabel('Single-Sided Amplitude Spectrum')
end