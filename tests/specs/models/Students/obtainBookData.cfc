/**
 * My BDD Test
 */
component extends="coldbox.system.testing.basetestcase" {

	/*********************************** LIFE CYCLE Methods ***********************************/
	// executes before all suites+specs in the run() method
	function beforeAll(){
		super.beforeAll();
		variables.testboxMockingUtils = getInstance("mocking@testboxMockingUtils");
	}

	// executes after all suites+specs in the run() method
	function afterAll(){
		variables.testboxMockingUtils.reloadModule("qb");
	}

	/*********************************** BDD SUITES ***********************************/

	function run( testResults, testBox ){
		// all your suites go here.
		describe( "ObtainStyle should", function(){
			beforeEach( function(){
				mockHyper = createMock(object=getInstance("HyperBuilder@hyper"));
				mockHyper.$(method="send");

				testObj = createMock( object = getInstance( "students@ninja" ) );
				testObj.setHyper(mockHyper);
				testme = testObj.obtainBookData();
				writeDump(testme);
				writeDump(mockHyper);
			} );
			it( "from should be students", function(){
				//expect(mockQb.getFrom()).tobe("students");
			} );

		} );
	}

}

