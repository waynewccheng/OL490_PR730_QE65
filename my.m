%% Post-calibration of PR730
% check OL490 spectra with QE65-Pro

% data collected by Paul on 2/14/2020
load('lambda_pr.mat')
load('lambda_qe.mat')
load('spectra_backgound_pr.mat')
load('spectra_backgound_qe.mat')
load('spectra_pr.mat')
load('spectra_qe.mat')

% data collected by WCC on 2/14/2020
load('qe65pro_dark','lambda_qe_dark','spectra_qe_dark','mask')

%% OL490 on

if 0
    
    for i = 1:41
        
        % wavelength
        wl = 380+10*(i-1);
        
        % graph
        clf
        
        % calculate ratio
        max_pr = max(spectra_pr(i,:))
        max_qe = max(spectra_qe(i,mask))
        r = max_qe/max_pr
        [wl max_pr max_qe r]
        
        
        % plot QE65 dark
        hold on
        plot(lambda_qe_dark(mask),spectra_qe_dark(mask)/r,'.b')
        
        % plot QE65
        plot(lambda_qe(mask),spectra_qe(i,mask)/r,':r')
        
        % plot PR730
        plot(lambda_pr,spectra_pr(i,:),'g')
        
        %
        legend('QE','QE','PR')
        
        % define viewport
        axis([360 800 0 max_pr*1.1])
        
        % labeling
        title(sprintf('OL490 at %d nm',wl))
        xlabel('Wavelength (nm)')
        ylabel('SPD')
        
        % image file
        saveas(gcf,sprintf('%d.png',wl))
        
    end
end




%% OL490 off
if 0
    figure
    
    spectra_pr = spectra_backgound_pr;
    spectra_qe = spectra_backgound_qe;
    
    % average over 41
    spectra_pr_mean = mean(spectra_pr(:,:),1);
    spectra_qe_mean = mean(spectra_qe(:,mask),1);
    clf
    max_pr = max(spectra_pr_mean);
    max_qe = max(spectra_qe_mean);
    r = max_qe/max_pr;
    plot(lambda_pr,spectra_pr_mean,'g')
    hold on
    plot(lambda_qe(mask),spectra_qe_mean/r,':r')
    axis([380 780 0 max_pr*1.1])
    
    legend('PR730','QE normalized')
    title('OL490 Off')
    xlabel('Wavelength (nm)')
    ylabel('SPD')
    saveas(gcf,sprintf('bacground.png'))
end

%% background generate each graph -- not useful
if 0
    spectra_pr = spectra_backgound_pr;
    spectra_qe = spectra_backgound_qe;

    for i = 1:41
        wl = 380+10*(i-1);
        clf
        max_pr = max(spectra_pr(i,:));
        max_qe = max(spectra_qe(i,mask));
        r = max_qe/max_pr;
        plot(lambda_pr,spectra_pr(i,:),'g')
        hold on
        plot(lambda_qe(mask),spectra_qe(i,mask)/r,':r')
        axis([380 780 0 max_pr*1.1])
        
        legend('PR730','QE normalized')
        title(sprintf('%d',wl))
        xlabel('Wavelength (nm)')
        ylabel('SPD')
        saveas(gcf,sprintf('bg%d.png',wl))
    end
end