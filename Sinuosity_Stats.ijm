macro "Sinuosity_Stats [f3]" {

    pathfile = File.openDialog( "Choose the file to Open:" ); 
    filestring = File.openAsString( pathfile ); 

    rows = split( filestring, "\n" ); 
    x1 = newArray( rows.length ); 
    y1 = newArray( rows.length );
    x2 = newArray( rows.length ); 
    y2 = newArray( rows.length ); 
    EuclidLen = newArray( rows.length ); 
    curveLen = newArray( rows.length );  

    // column counts hardcoded: there are 6 columns
    for( i = 0; i < rows.length; i++ ){ 
	    columns = split( rows[i], "\t" ); 
    	x1[i] = parseInt( columns[0] ); 
    	y1[i] = parseInt( columns[1] );
    	x2[i] = parseInt( columns[2] ); 
    	y2[i] = parseInt( columns[3] );
    	EuclidLen[i] = parseFloat( columns[4] );
    	curveLen[i] = parseFloat( columns[5] ); 
    } 

    sinuosity = newArray( rows.length );

    for( i = 0; i < rows.length; i++ ){
	    sinuosity[i] = curveLen[i] / EuclidLen[i];
    }

    width = getWidth();
    widthThird = width / 3;

    sectionCounts = newArray(3);
    for( i = 0 ; i < 6; i++ ){
    	j = 0;
    	for( k = j; k < 27; k++ ){
	
	if( i * widthThird < x1[k] && x1[k] < ( i + 1 ) * widthThird ){
		sectionCounts[i]++;
		j++;
	}
        }

    }

    sectionSums = newArray(3);
    sectionAVG = newArray(3);
    offset = 0;
    for( i=0; i < 3; i++ ){
	    if( i > 0 ){
		    offset += sectionCounts[ i - 1 ];
	}
    	for( j = offset; j < offset + sectionCounts[i]; j++){
	    	sectionSums[i] += sinuosity[j];
	    }
	
	sectionAVG[i] = sectionSums[i] / sectionCounts[i];
	
    }

    sectionSTDEV = newArray(3);
    stdev = 0;
    offset = 0;
    for( i = 0; i < 3; i++ ){
        if( i > 0 ){
	    	offset += sectionCounts[ i - 1 ];
	    }
    	stdevSum = 0;
    	stdev = 0;
	for(j = offset; j < offset + sectionCounts[i] ; j++ ){
		stdevSum += pow( ( sectionAVG[i] - sinuosity[j] ), 2 );
	}
	sectionSTDEV[i] = pow( stdevSum / ( sectionCounts[i] -1 ), 0.5 );
    }   

    sectionNames = newArray( "Left Section:", "Middle Section:", "Right Section:" );
    
    // plus or minus symbol explicitly declared here using the java code
    plusminus = fromCharCode(0x000000B1);

    for( i = 0; i < 3; i++ ){
	    print( sectionNames[i], sectionAVG[i], plusminus, sectionSTDEV[i], ";", "n =", sectionCounts[i] );
    }
}
