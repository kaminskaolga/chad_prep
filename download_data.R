library(data.table)
library("RPostgreSQL")
library(dplyr)

# Connect to the default postgres database
con <- dbConnect(dbDriver("PostgreSQL"),
                 dbname = "CHAD",
                 host = "zoolook.ibspan.waw.pl",
                 port = 5432)


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

columns <- c("dwh_mobilerecording_id" , parametry)


#pacjenci <- dbGetQuery(
  #con,
 # "select  p.patient_id as ss,* from dwh_chad.patients_33 as p")


#recording <- dbGetQuery(con , "select patient_id from dwh_chad.mobilerecordings mr group by patient_id")

#dbListTables(con)

#wizyty <- dbGetQuery(con , "select patient_id from dwh_chad.visits mr group by patient_id")
#mrc <- dbGetQuery(con , "select patient_id from dwh_chad.mobilerecordingchunks mr group by patient_id") 

recordings_only <- dbGetQuery(
  con,
    "select  p.patient_id, create_date as create_date,
    mr.dwh_mobilerecording_id
    from  dwh_chad.mobilerecordings mr
    left join dwh_chad.patients_33 as p on 
    mr.patient_id = p.patient_id
    where create_date > '20180101' and create_date < '20190101' 
    and p.patient_id is not null limit 100"
)

recordings_only$create_date <- as.Date(recordings_only$create_date)

recordings_only <- unique(recordings_only)

#staty
recording_stats <- recordings_only %>% 
  group_by(patient_id) %>%
  summarise(liczba_pol = n() ,
            min_d = as.Date(min(create_date)) ,
            max_d = as.Date(max(create_date))) %>%
  arrange(liczba_pol)

pat <- recording_stats$patient_id

#pat <- c("8736")#,"9341","9643")

for (p in pat) {
  print(p)
  #wybieram dni z rozmów
  days <- 
    recordings_only[recordings_only$patient_id == p , "create_date"] %>%
    unique() %>%
    as.Date()
  lista <- list()
  for (d in days) { #dla kazdego dnia z rozmowami
    d <- as.Date(d , origin = "1970-01-01")
    print(d)
    #wybieram wszystkie nagrania w tym dniu
    chunks_pat <- recordings_only[recordings_only$create_date == d &
                                recordings_only$patient_id == p ,
                              "dwh_mobilerecording_id"]
    chunki <- chunks_pat[!is.na(chunks_pat)]
    chunki <-
      paste0(chunki, sep = ",", collapse = '') #złączenie w stringa
    chunki <- gsub(".$", "", chunki) #wywalenie ostatniego przecinka
    chunks_only_ <-
      dbGetQuery(
        con,
        paste0(
          "select  *  from  dwh_chad.mobilerecordingchunks
          where patient_id =  '" , p , "'",
          " and dwh_mobilerecording_id in (" ,
          chunki ,
          ")  ", ";"
        )
      ) %>% as.data.table()
    if(nrow(chunks_only_) == 0) next
    #przeliczanie parametrow
    lista_chunk <- list() #lista dla 
    
    for(chunk in chunks_pat) #dla kadego chunka z 1 dnia przeliczam parametry
    {
      print(chunk)
      one_chunk <- chunks_only_[dwh_mobilerecording_id == chunk ,
                                ..columns]
      
      srednia_ <- lapply(one_chunk , mean)
      skosnosc_ <- lapply(one_chunk , timeDate::skewness) 
      odchylenie_sd_ <- lapply(one_chunk , sd) 
      quantiles_ <-  lapply(one_chunk , quantile, na.rm=TRUE)
      
      v0_freq_ <- lapply(one_chunk , function(x) {length(which(x == 0)) / length(x)})
      v1_freq_ <- lapply(one_chunk , function(x) {length(which(x == 1)) / length(x)})
      
      calc <- bind_rows(srednia_,skosnosc_,odchylenie_sd_,quantiles_,v0_freq_,v1_freq_)
      calc$parametr <- c("srednia","skosnosc","odchylenie_sd","q0","q1","q2","q3","q4","v0","v1")
      calc$recording <- chunk
      
      calc$day <- as.character(d)
      d <- as.character(d)
      #dbSendQuery(con, "insert into dwh_chad.recordings_quantiles" ,calc,append=TRUE)
      chunk<- as.character(chunk)
      lista_chunk[[chunk]] <- calc
      rm(srednia_,skosnosc_,odchylenie_sd_,quantiles_,v0_freq_,v1_freq_,calc)
    }
    bindl <- bind_rows(lista_chunk, .id = "mobilerecording_id")
    lista[[d]] <- bindl
    rm(bindl)
  }
  lista_total <- bind_rows(lista,.id = "dzien")
  rm(lista)
  #lista_total$dw_mobilerecording_id <- NULL
  d_path <- paste0('Q:\\kaminska\\dane\\p_',p,'.csv')
  write.csv(lista_total , d_path)
}

#wizyty <- dbGetQuery(con, "select * from dwh_chad.visits")
#write.csv(wizyty, "wizyty.csv")