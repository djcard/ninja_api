/**
 * My BDD Test
 */
component extends="coldbox.system.testing.basetestcase" {

	/*********************************** LIFE CYCLE Methods ***********************************/
	// executes before all suites+specs in the run() method
	function beforeAll(){
		super.beforeAll();
		super.setup();
	}

	// executes after all suites+specs in the run() method
	function afterAll(){
	}

	/*********************************** BDD SUITES ***********************************/

	function run( testResults, testBox ){
		// all your suites go here.
		describe( "ObtainStyle should", function(){
			it( "Return `level` and whatever is submitted", function(){
				expect( true ).tobeFalse();
				// var testObj = getInstance( "students@ninja" );
				// var fakeVal = randRange( 1, 1000 );
				// var testme  = testObj.obtainStyle( fakeVal );
				// expect( testme ).tobe( "level#fakeVal#" );
			} );
			it( "If a non-number is submitted, throw an error", function(){
				expect( true ).tobeFalse();
				// var testObj = getInstance( "students@ninja" );

				// expect( function(){
				//	testObj.obtainStyle( {} );
				// } ).tothrow( type = "expression", message = "A struct did not throw an exception" );

				// expect( function(){
				//	testObj.obtainStyle( [] );
				// } ).tothrow( type = "expression", message = "An array did not throw an exception" );

				// $assert.throws(
				//	target = function(){
				//		testObj.obtainStyle( "a" );
				//	},
				//	type    = "expression",
				//	message = "A string did not throw an exception"
				// );
			} );
		} );
	}

}

