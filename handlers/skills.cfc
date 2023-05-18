component extends="coldbox.system.resthandler" {

	property name="skillService" inject="skills@ninja";

	function index( event, rc, prc ){
		prc.response.setData( skillService.allSkills() );
	}

}
