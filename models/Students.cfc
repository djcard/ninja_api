component accessors="true" {

	property name="qb"           inject="provider:QueryBuilder@qb";
	property name="wirebox"      inject="wirebox";
	property name="skillService" inject="models.skills";
	property name="hyper"        inject="HyperBuilder@Hyper";
	property name="maxLevel" default="2";

	function init(){
		return this;
	}


	/***
	 * Returns the CSS class corresponding with the submitted skill level
	 *
	 * @value - A numeric value, typically 1-6 as of 23 Jun 2023
	 **/
	function obtainStyle( required numeric value ){
		return "level#value#";
	}



	/***
	 * Creates the array of student skill and level data needed to create the display table
	 *
	 * @id optional numeric student id.
	 **/
	function createStudentArray( numeric id = 0 ){
		var tableData   = [ { "contents" : createHeaderRow(), "classes" : "" } ];
		var studentRows = createStudentRows( arguments.id );
		return isNull( studentRows ) ? tableData : tableData.append( studentRows, true );
	}




	function obtainStudentData( id = 0 ){
		return qb
			.from( "students" )
			.setGrammar( wirebox.getInstance( "SqlServerGrammar@qb" ) )
			.when( id > 0, function( q ){
				q.where( "id", "=", id );
			} )
			.get( options = { datasource : "ninja" } );
	}


	/***
	 * Creates the top header for the skills display table. The first column should be blank and each subsequent be the name of a skill.
	 *
	 * @headerData - an array of structs, each must have the key `name`
	 **/
	Array function createHeaderRow(){
		var allSkills = skillService.allSkills();
		var base      = [ { "header" : true, "contents" : "", "classes" : "" } ];
		allSkills.each( function( item ){
			base.append( { "header" : true, "contents" : item.name, "classes" : "" } );
		} );

		base.append( { "header" : true, "contents" : "Level", "classes" : "" } );

		return base;
	}


	/***
	 * Accepts an array of skillLevels and returns the lowest level
	 *
	 * @skillData - an array of structs, each with the key skillLevel
	 **/
	function findStudentLevel( required array skillData = studentData, string keyName = "skillLevel" ){
		return skillData.reduce( function( currLevel, item ){
			return item[ keyName ] < currLevel ? item[ keyName ] : currLevel;
		}, 10 );
	}

	/***
	 * Queries the database and returns all skill levels for all students unless a studentId is submitted (all skills for that student), a skillCode (all scores for that skillCode) or both ( a particular skill for a particular student)
	 *
	 * @studentId - numeric id for a student
	 * @skillCode -
	 **/
	function studentSkills( numeric studentId = 0, string skillCode = "" ){
		return qb
			.setGrammar( wirebox.getInstance( "SqlServerGrammar@qb" ) )
			.from( "studentSkill" )
			.when( studentId > 0, function( q ){
				q.where( "studentId", "=", studentId );
			} )
			.when( skillCode.len() > 0, function(){
				q.where( "skillCode", "=", skillCode );
			} )
			.get( options = { datasource : "ninja" } );
	}

	function createStudentSkillDictionary(){
		var returnMe    = {};
		var studentdata = studentSkills();

		studentData.each( function( item ){
			returnMe[ item.studentId.toString() ] = returnMe.keyExists( item.studentId.toString() ) ? returnMe[
				item.studentId.toString()
			] : {};
			returnMe[ item.studentId.toString() ][ item.skillCode ] = item.skillLevel;
		} );

		return returnMe;
	}






	/***
	 *
	 * Creates each row of student Each column (cell) pertains to a skill and the number in the cell is the level the student is on.
	 *
	 * @studentData - Array of Structs referring to student names. Must have firstname, lastname, and id
	 * @allSkills   - Array of Structs referring to the skills taught by the gym. Must have key `code`
	 * @skillData   - Struct with students IDs as the first key and skillCode as the next level in with the skill level as the value
	 ***/
	array function createStudentRows( required numeric id = 0 ){
		var returnMe = [];

		var studentData = obtainStudentData( id );
		var allSkills   = skillService.allSkills();
		var skillData   = createStudentSkillDictionary();


		// Loop Over the student array
		studentData.each( function( student ){
			// Create the base of the student struct
			var studentBase = createStudentBase( student.firstname, student.lastname );

			// Loop over the skills array
			allSkills.each( function( skill ){
				// Retrieve the student's recorded skill level or display a 0
				var cellValue = skillData.keyExists( student.id.toString() ) && skillData[ student.id.toString() ].keyExists(
					skill.code
				)
				 ? skillData[ student.id.toString() ][ skill.code ]
				 : 0;

				// Append this "cell" to the "row" array
				studentBase.contents.append(
					{
						"contents" : cellValue,
						"header"   : false,
						"classes"  : obtainStyle( cellValue )
					},
					true
				);
			} );

			var totalLevel = findStudentLevel( studentBase.contents, "contents" );
			studentBase.contents.append( {
				"contents" : totalLevel,
				"header"   : false,
				"classes"  : obtainStyle( totalLevel )
			} )
			// Append the "row" to the returnMe array
			returnMe.append( studentBase, true );
		} );

		// Return the assembled table data
		return returnMe;
	}

	struct function createStudentBase( required string firstName = "", required string lastName = "" ){
		return {
			"classes"  : "",
			"contents" : [
				{
					"contents" : firstName & " " & left( arguments.lastName, 1 ).ucase(),
					"header"   : false,
					"classes"  : ""
				}
			]
		};
	}





	function bumpSkills( required numeric studentId, required string skillCode ){
		// Get the student's current skill from the DB
		var currentLevel = studentSkills( studentId, skillCode );

		// Do the logic to bump up the level
		var newlevel = currentLevel.len() && currentLevel[ 1 ].keyExists( "skillLevel" ) && isValid(
			"numeric",
			currentLevel[ 1 ].skillLevel
		)
		 ? currentLevel[ 1 ].skillLevel + 1
		 : 1;

		// Access the skill service and save the new skill level in the DB
		skillService.saveSkillLevel( studentId, skillCode, newlevel );
		return true;
	}

	function obtainBookData( isbn = "9780062196538" ){
		return hyper
			.setMethod( "post" )
			.setURL( "https://openlibrary.org/api/books?bibkeys=ISBN:#arguments.isbn#&format=json" );
	}

}
