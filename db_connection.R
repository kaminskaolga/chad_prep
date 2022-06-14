#install.packages("RPostgreSQL")
library("RPostgreSQL")
library(dplyr)

# Connect to the default postgres database
con <- dbConnect(dbDriver("PostgreSQL"),
                 dbname = "CHAD",
                 host = "zoolook.ibspan.waw.pl",
                 port = 5432)

dbListTables(con) %>% View()










dane <- dbGetQuery(con, "SELECT * FROM mobilerecordings
                   limit 100")

dbGetQuery(con, "SELECT * FROM date
                   limit 100")

dbGetQuery(con, "SELECT nspname FROM pg_catalog.pg_namespace;")

dbGetQuery(con, "SELECT table_name FROM information_schema.tables 
WHERE table_schema = 'dwh_chad' ")


dane2 <- dbGetQuery(con, "SELECT * FROM dwh_chad.mobilerecordings
                   limit 100")

dane3 <- dbGetQuery(con, "SELECT * FROM dwh_chad.recordings_quantiles ")

dane4 <- dbGetQuery(con, "SELECT * FROM dwh_chad.patients_33 ")

dbSendQuery(con , "create table dwh_chad.patients_33 (
patient_id character(4),
            dwh_patient_id numeric)")

dbSendQuery(con , "insert into dwh_chad.patients_33 (patient_id) values
(108),
(464),
            (837),
            (1358),
            (1472),
            (1495),
            (2004),
            (2582),
            (4003),
            (4248),
            (4614),
            (4656),
            (4923),
            (4953),
            (4994),
            (5500),
            (5656),
            (5659),
            (5736),
            (5768),
            (6139),
            (6601),
            (6754),
            (7061),
            (8193),
            (8292),
            (8560),
            (8736),
            (8866),
            (9337),
            (9341),
            (9643),
            (9829)
") 


dbSendQuery(con , "create table dwh_chad.recordings_quantiles (
pcm_LOGenergy_sma numeric,
pcm_zcr_sma numeric,
voiceprob_sma numeric,
f0_sma numeric,
f0env_sma numeric,
pcm_fftMag_fband0_250_sma numeric,
pcm_fftMag_fband0_650_sma numeric,
pcm_fftMag_spectralRollOff25_0_sma numeric,
pcm_fftMag_spectralRollOff50_0_sma numeric,
pcm_fftMag_spectralRollOff75_0_sma numeric,
pcm_fftMag_spectralRollOff90_0_sma numeric,
pcm_fftmag_spectralflux_sma numeric,
pcm_fftmag_spectralcentroid_sma numeric,
pcm_fftmag_spectralmaxpos_sma numeric,
pcm_fftmag_spectralminpos_sma numeric,
f0final_sma numeric,
voicingfinalunclipped_sma numeric,
jitterlocal_sma numeric,
jitterddp_sma numeric,
shimmerlocal_sma numeric,
loghnr_sma  numeric,
audspec_lengthl1norm_sma  numeric,
audspecrasta_lengthl1norm_sma  numeric,
pcm_rmsenergy_sma numeric,
audSpec_Rfilt_sma_compare_0_  numeric,
audSpec_Rfilt_sma_compare_1_  numeric,
audSpec_Rfilt_sma_compare_2_ numeric,
audSpec_Rfilt_sma_compare_3_  numeric,
audSpec_Rfilt_sma_compare_4_ numeric,
audSpec_Rfilt_sma_compare_5_ numeric,
audSpec_Rfilt_sma_compare_6_ numeric,
audSpec_Rfilt_sma_compare_7_ numeric,
audSpec_Rfilt_sma_compare_8_ numeric,
audSpec_Rfilt_sma_compare_9_ numeric,
audSpec_Rfilt_sma_compare_10_ numeric,
audSpec_Rfilt_sma_compare_11_ numeric,
audSpec_Rfilt_sma_compare_12_ numeric,
audSpec_Rfilt_sma_compare_13_ numeric,
audSpec_Rfilt_sma_compare_14_ numeric,
audSpec_Rfilt_sma_compare_15_ numeric,
audSpec_Rfilt_sma_compare_16_ numeric,
audSpec_Rfilt_sma_compare_17_ numeric,
audSpec_Rfilt_sma_compare_18_  numeric,
audSpec_Rfilt_sma_compare_19_ numeric,
audSpec_Rfilt_sma_compare_20_ numeric,
audSpec_Rfilt_sma_compare_21_  numeric,
audSpec_Rfilt_sma_compare_22_ numeric,
audSpec_Rfilt_sma_compare_23_ numeric,
audSpec_Rfilt_sma_compare_24_  numeric,
audSpec_Rfilt_sma_compare_25_ numeric,
pcm_fftMag_fband250_650_sma_compare numeric,
pcm_fftMag_fband1000_4000_sma_compare  numeric,
pcm_fftmag_spectralentropy_sma_compare numeric,
pcm_fftmag_spectralvariance_sma_compare  numeric,
pcm_fftmag_spectralskewness_sma_compare numeric,
pcm_fftmag_spectralkurtosis_sma_compare  numeric,
pcm_fftmag_psysharpness_sma_compare numeric,
pcm_fftmag_spectralharmonicity_sma_compare  numeric,
loudness_sma3  numeric,
alpharatio_sma3 numeric,
hammarbergindex_sma3 numeric,
slope0_500_sma3  numeric,
slope500_1500_sma3  numeric,
F0semitoneFrom27_5Hz_sma3nz  numeric,
logRelF0_H1_H2_sma3nz numeric,
logRelF0_H1_A3_sma3nz numeric,
f1frequency_sma3nz  numeric,
f1bandwidth_sma3nz numeric,
f1amplitudelogrelf0_sma3nz numeric,
f2frequency_sma3nz  numeric,
f2amplitudelogrelf0_sma3nz numeric,
f3frequency_sma3nz  numeric,
f3amplitudelogrelf0_sma3nz numeric,
pcm_fftMag_mfcc_0_ numeric,
pcm_fftMag_mfcc_1_  numeric,
pcm_fftMag_mfcc_2_  numeric,
pcm_fftMag_mfcc_3_  numeric,
pcm_fftMag_mfcc_4_ numeric,
pcm_fftMag_mfcc_5_  numeric,
pcm_fftMag_mfcc_6_  numeric,
pcm_fftMag_mfcc_7_  numeric,
pcm_fftMag_mfcc_8_  numeric,
pcm_fftMag_mfcc_9_ numeric,s
pcm_fftMag_mfcc_10_  numeric,
pcm_fftMag_mfcc_11_ numeric,
pcm_fftMag_mfcc_12_  numeric,
parametr nvarchar(100),
recording  numeric,
day date
)")

