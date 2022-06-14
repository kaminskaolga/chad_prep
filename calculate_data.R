
library(data.table)
library(dplyr)
library(ggplot2)

fl_171 <- list.files(path = "/Volumes/Extreme 500/CHAD_dane/p_171")
fl_163 <- list.files(path = "/Volumes/Extreme 500/CHAD_dane/p_163")

parametry <-
  c(
    "pcm_LOGenergy_sma",
    "pcm_zcr_sma" ,
    "voiceprob_sma" ,
    "f0_sma" ,
    "f0env_sma",
    "pcm_fftMag_fband0-250_sma" ,
    "pcm_fftMag_fband0-650_sma",
    "pcm_fftMag_spectralRollOff25_0_sma" ,
    "pcm_fftMag_spectralRollOff50_0_sma",
    "pcm_fftMag_spectralRollOff75_0_sma",
    "pcm_fftMag_spectralRollOff90_0_sma",
    "pcm_fftmag_spectralflux_sma",
    "pcm_fftmag_spectralcentroid_sma" ,
    "pcm_fftmag_spectralmaxpos_sma" ,
    "pcm_fftmag_spectralminpos_sma" ,
    "f0final_sma" ,
    "voicingfinalunclipped_sma",
    "jitterlocal_sma",
    "jitterddp_sma",
    "shimmerlocal_sma",
    "loghnr_sma",
    "audspec_lengthl1norm_sma" ,
    "audspecrasta_lengthl1norm_sma" ,
    "pcm_rmsenergy_sma",
    "audSpec_Rfilt_sma_compare_0_",
    "audSpec_Rfilt_sma_compare_1_" ,
    "audSpec_Rfilt_sma_compare_2_" ,
    "audSpec_Rfilt_sma_compare_3_" ,
    "audSpec_Rfilt_sma_compare_4_",
    "audSpec_Rfilt_sma_compare_5_",
    "audSpec_Rfilt_sma_compare_6_" ,
    "audSpec_Rfilt_sma_compare_7_",
    "audSpec_Rfilt_sma_compare_8_",
    "audSpec_Rfilt_sma_compare_9_",
    "audSpec_Rfilt_sma_compare_10_",
    "audSpec_Rfilt_sma_compare_11_",
    "audSpec_Rfilt_sma_compare_12_",
    "audSpec_Rfilt_sma_compare_13_",
    "audSpec_Rfilt_sma_compare_14_",
    "audSpec_Rfilt_sma_compare_15_" ,
    "audSpec_Rfilt_sma_compare_16_",
    "audSpec_Rfilt_sma_compare_17_",
    "audSpec_Rfilt_sma_compare_18_" ,
    "audSpec_Rfilt_sma_compare_19_" ,
    "audSpec_Rfilt_sma_compare_20_" ,
    "audSpec_Rfilt_sma_compare_21_" ,
    "audSpec_Rfilt_sma_compare_22_" ,
    "audSpec_Rfilt_sma_compare_23_" ,
    "audSpec_Rfilt_sma_compare_24_" ,
    "audSpec_Rfilt_sma_compare_25_",
    "pcm_fftMag_fband250-650_sma_compare" ,
    "pcm_fftMag_fband1000-4000_sma_compare",
    "pcm_fftmag_spectralentropy_sma_compare",
    "pcm_fftmag_spectralvariance_sma_compare" ,
    "pcm_fftmag_spectralskewness_sma_compare",
    "pcm_fftmag_spectralkurtosis_sma_compare" ,
    "pcm_fftmag_psysharpness_sma_compare" ,
    "pcm_fftmag_spectralharmonicity_sma_compare",
    "loudness_sma3",
    "alpharatio_sma3",
    "hammarbergindex_sma3" ,
    "slope0-500_sma3" ,
    "slope500-1500_sma3",
    "F0semitoneFrom27_5Hz_sma3nz",
    "logRelF0-H1-H2_sma3nz",
    "logRelF0-H1-A3_sma3nz" ,
    "f1frequency_sma3nz" ,
    "f1bandwidth_sma3nz" ,
    "f1amplitudelogrelf0_sma3nz" ,
    "f2frequency_sma3nz" ,
    "f2amplitudelogrelf0_sma3nz" ,
    "f3frequency_sma3nz" ,
    "f3amplitudelogrelf0_sma3nz",
    "pcm_fftMag_mfcc_0_" ,
    "pcm_fftMag_mfcc_1_" ,
    "pcm_fftMag_mfcc_2_" ,
    "pcm_fftMag_mfcc_3_",
    "pcm_fftMag_mfcc_4_" ,
    "pcm_fftMag_mfcc_5_" ,
    "pcm_fftMag_mfcc_6_",
    "pcm_fftMag_mfcc_7_",
    "pcm_fftMag_mfcc_8_",
    "pcm_fftMag_mfcc_9_",
    "pcm_fftMag_mfcc_10_",
    "pcm_fftMag_mfcc_11_",
    "pcm_fftMag_mfcc_12_"
  )

columns <- c("dw_mobilerecording_id" , parametry)


fl_171_list <- list()
fl_163_list <- list()

#for(f in fl_171){ #dla każdego dnia
for(f in fl_163){ #dla każdego dnia
  #  file <- fread(paste0("/Volumes/Extreme 500/CHAD_dane/p_171/",f)) 
  file <- fread(paste0("/Volumes/Extreme 500/CHAD_dane/p_163/",f)) 
  day_recordings <- unique(file$dw_mobilerecording_id) #dla każdego nagrania w tym pliku
  for(d in day_recordings){
    print(d)
    filess <- file[dw_mobilerecording_id == d , ..columns]
    
    srednia_ <- lapply(filess , mean)
    skosnosc_ <- lapply(filess , timeDate::skewness) 
    odchylenie_sd_ <- lapply(filess , sd) 
    quantiles_ <-  lapply(filess , quantile)
    v0_freq_ <- lapply(filess , function(x) {length(which(x == 0)) / length(x)})
    v1_freq_ <- lapply(filess , function(x) {length(which(x == 1)) / length(x)})
    
    calc <- bind_rows(srednia_,skosnosc_,odchylenie_sd_,quantiles_,v0_freq_,v1_freq_)
    calc$parametr <- c("srednia","skosnosc","odchylenie_sd","q0","q1","q2","q3","q4","v0","v1")
    calc$recording <- d
    
    gg<- gsub(pattern = "_p_163.csv", replacement = "",x = f)
    #gg<- gsub(pattern = "_p_171.csv", replacement = "",x = f)
    gg <- gsub(pattern = "rec_", replacement = "",x = gg)
    gg <- gsub(pattern = "_", replacement = "-",x = gg)
    gg <- as.Date(gg)
    
    calc$day <- gg
    d <- as.character(d)
    #fl_171_list[[d]] <- calc
    fl_163_list[[d]] <- calc
  }
}
s

#p_171_calc <- bind_rows(fl_171_list)
#p_171_calc$dw_mobilerecording_id <- NULL
#write.csv(p_171_calc , "pacjent_3473.csv")

p_163_calc <- bind_rows(fl_163_list)
p_163_calc$dw_mobilerecording_id <- NULL

write.csv(p_163_calc , "pacjent_6601.csv")

