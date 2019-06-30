macro "Stratified_Sections [f2]"{

    width = getWidth();
    height = getHeight();

    thirdWidth = width / 3;

    for( i = 1; i <= 2; i++ ){
	    makeLine( thirdWidth * i, 0, thirdWidth * i, height, 4 );
	    run( "Add Selection...","stroke = green" );
    };

    eighthHeight = height / 8;
    ninthWidth = width / 9;

    for( j=1; j <= 8; j++ ){
        
        if( j % 3 != 0 ){	
            for( i = 1; i <= 7; i++ ){
	            makePoint( ninthWidth * j, i * eighthHeight );
	            run( "Add Selection...", "stroke = green" );
            };
        };
    };

    run( "Select None" );

};
