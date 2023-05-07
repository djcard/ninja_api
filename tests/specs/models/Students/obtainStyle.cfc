/**
 * My BDD Test
 */
component extends="coldbox.system.testing.basetestcase" {

	/*********************************** LIFE CYCLE Methods ***********************************/
	// executes before all suites+specs in the run() method
	function beforeAll(){
		super.beforeAll();
	}

	// executes after all suites+specs in the run() method
	function afterAll(){
	}

	/*********************************** BDD SUITES ***********************************/

	function run( testResults, testBox ){
		// all your suites go here.
		describe( "ObtainStyle should", function(){
			beforeEach( function(){
				testObj = getInstance( "students@ninja" );
			} );
			it( "Return `level` and whatever is submitted", function(){
				expect( true ).tobeFalse();
				// var fakeVal = randRange( 1, 1000 );
				// var testme  = testObj.obtainStyle( fakeVal );
				// expect( testme ).tobe( "level#fakeVal#" );
			} );
			it( "If a non-number is submitted, throw an error", function(){
				expect( function(){
					testObj.obtainStyle( {}, "A struct did not throw an exception" );
				} ).tothrow( "expression" );
				expect( function(){
					testObj.obtainStyle( [], "An array did not throw an exception" );
				} ).tothrow( "expression" );
				$assert.throws( function(){
					testObj.obtainStyle( "a", "A string did not throw an exception" );
				}, "expression" );
			} );
		} );
	}

}

