component {

	property name="qb"      inject="provider:QueryBuilder@qb";
	property name="wirebox" inject="wirebox";

	function allSkills( code = "" ){
		return qb
			.from( "skills" )
			.setGrammar( wirebox.getInstance( "SqlServerGrammar@qb" ) )
			.when( code.len() > 0, function( q ){
				q.where( "skillCode", "=", code );
			} )
			.get( options = { datasource : "ninja" } );
	}

	function saveSkillLevel( studentId, skillCode, skillLevel ){
		qb.setGrammar( wirebox.getInstance( "SqlServerGrammar@qb" ) )
			.from( "studentSkill" )
			.updateOrInsert(
				{
					studentId  : studentId,
					skillCode  : skillCode,
					skillLevel : skillLevel
				},
				{ datasource : "ninja" }
			);
	}

}
