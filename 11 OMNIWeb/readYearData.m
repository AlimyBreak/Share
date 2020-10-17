function [data] = readYearData(file_path,file_name,time_begin,time_end,var_list)

	%{
	High-Resolution OMNI data set(https://omniweb.gsfc.nasa.gov/html/HROdocum.html)

	 WORDS                        Format  Fill val     Comments
	 1 Year			        I4	                1995 .....
	 2 Day			        I4	                 1 ... 365 or 366
	 3 Hour			        I3	                 0 ... 23
	 4 Minute			I3   	            0 ... 59 at start of average
	 5 ID for IMF spacecraft	I3       99          See  footnote D below
	 6 ID for SW Plasma spacecraft	 I3	 99                 See  footnote D below
	 7 # of points in IMF averages	 I4      999
	 8 # of points in Plasma averages I4     999
	 9 Percent interp		I4	 999       See  footnote A above
	10 Timeshift, sec		I7     999999
	11 RMS, Timeshift		I7     999999
	12 RMS, Phase front normal	F6.2	99.99       See Footnotes E, F below
	13 Time btwn observations, sec	I7      999999        DBOT1, See  footnote C above
	14 Field magnitude average, nT	F8.2   9999.99
	15 Bx, nT (GSE, GSM)		F8.2   9999.99
	16 By, nT (GSE)		        F8.2   9999.99
	17 Bz, nT (GSE)		        F8.2   9999.99
	18 By, nT (GSM)	                F8.2   9999.99	        Determined from post-shift GSE components
	19 Bz, nT (GSM)	                F8.2   9999.99          Determined from post-shift GSE components
	20 RMS SD B scalar, nT	        F8.2   9999.99
	21 RMS SD field vector, nT	F8.2   9999.99	              See  footnote E below
	22 Flow speed, km/s		F8.1   99999.9
	23 Vx Velocity, km/s, GSE	F8.1   99999.9
	24 Vy Velocity, km/s, GSE	F8.1   99999.9
	25 Vz Velocity, km/s, GSE	F8.1   99999.9
	26 Proton Density, n/cc		F7.2    999.99
	27 Temperature, K		F9.0   9999999.
	28 Flow pressure, nPa		F6.2	 99.99           See  footnote G below		
	29 Electric field, mV/m		F7.2	999.99          See  footnote G below
	30 Plasma beta		        F7.2	999.99          See  footnote G below
	31 Alfven mach number		F6.1	 999.9          See  footnote G below
	32 X(s/c), GSE, Re		F8.2   9999.99
	33 Y(s/c), GSE, Re		F8.2   9999.99
	34 Z(s/c), GSE, Re		F8.2   9999.99
	35 BSN location, Xgse, Re	F8.2   9999.99            BSN = bow shock nose
	36 BSN location, Ygse, Re	F8.2   9999.99
	37 BSN location, Zgse, Re 	F8.2   9999.99

	38 AE-index, nT                 I6       99999       See World Data Center for Geomagnetism, Kyoto
	39 AL-index, nT                 I6       99999       See World Data Center for Geomagnetism, Kyoto
	40 AU-index, nT                 I6       99999       See World Data Center for Geomagnetism, Kyoto
	41 SYM/D index, nT              I6       99999       See World Data Center for Geomagnetism, Kyoto
	42 SYM/H index, nT              I6       99999       See World Data Center for Geomagnetism, Kyoto
	43 ASY/D index, nT              I6       99999       See World Data Center for Geomagnetism, Kyoto
	44 ASY/H index, nT              I6       99999       See World Data Center for Geomagnetism, Kyoto
	45 PC(N) index,                 F7.2    999.99       See World Data Center for Geomagnetism, Copenhagen
	46 Magnetosonic mach number     F5.1     99.9        See  footnote G below
	%}

    file_full_path  = [ file_path , '\' , file_name];
    fid     		=  fopen(file_full_path,'r');
    original_data 	= fscanf(fid,'%d%d%d%d%d%d%d%d%d%d%d%f%d%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%d%d%d%d%d%d%d%f%f\n');
    original_data 	= reshape(original_data,46,length(original_data)/46)';
    fclose(fid);
	
    length_now 	= 1;
    init_minutes = (datenum(time_begin.Year ,time_begin.Month,time_begin.Day) - datenum(time_begin.Year,1,1) )*24*60 + time_begin.Hour*60;
    for ii = init_minutes:size(original_data,1)
        Year				=	original_data(ii,1);	          
        day           		=	original_data(ii,2);	
        Hour                =	original_data(ii,3);	
        Minute              =	original_data(ii,4);	
        id1                 =	original_data(ii,5);	
        id2                 =	original_data(ii,6);	
        points1             =	original_data(ii,7);	
        points2             =	original_data(ii,8);	
        percentInterp       =	original_data(ii,9);	
        Timeshift           =	original_data(ii,10);	
        RMS1                =	original_data(ii,11);	
        RMS2                =	original_data(ii,12);	
        TBO                 =	original_data(ii,13);	
        fma                 =	original_data(ii,14);	
        Bx                  =	original_data(ii,15);	
        By_GSE              =	original_data(ii,16);	
        Bz_GSE              =	original_data(ii,17);	
        By_GSM              =	original_data(ii,18);	
        Bz_GSM              =	original_data(ii,19);	
        RMS_B               =	original_data(ii,20);	
        RMS_FV              =	original_data(ii,21);	
        flowSpeed           =	original_data(ii,22);	
        Vx                  =	original_data(ii,23);	
        Vy                  =	original_data(ii,24);	
        Vz                  =	original_data(ii,25);	
        protonDensity       =	original_data(ii,26);	
        Temperature         =	original_data(ii,27);	
        flowPressure        =	original_data(ii,28);	
        electricField       =	original_data(ii,29);	
        plasmaBeta          =	original_data(ii,30);	
        AlfvenMachNum       =	original_data(ii,31);	
        X_sc                =	original_data(ii,32);	
        Y_sc                =	original_data(ii,33);	
        Z_sc                =	original_data(ii,34);	
        Xgse                =	original_data(ii,35);	
        Ygse                =	original_data(ii,36);	
        Zgse                =	original_data(ii,37);	
        AE                  =	original_data(ii,38);	
        AL                  =	original_data(ii,39);	
        AU                  =	original_data(ii,40);	
        SYM_D               =	original_data(ii,41);	
        SYM_H               =	original_data(ii,42);	
        ASY_D               =	original_data(ii,43);	
        ASY_H               =	original_data(ii,44);	
        PCN                 =	original_data(ii,45);	
        MagMachNum          =	original_data(ii,46);	
		
        [month_of_doy, day_of_doy] = Doy2Date(Year, day);
		curTime 	= datetime(Year,month_of_doy,day_of_doy,Hour,Minute,0);
		if curTime >= time_begin && curTime <= time_end
			data{1,length_now} = curTime;
			for jj = 1:length(var_list)
				data{jj+1,length_now} = eval(var_list{jj});
			end
			length_now = length_now + 1;
        else if curTime < time_begin
                continue;
            else if curTime > time_begin
                    break;
                end
            end
        end 
    end
end
