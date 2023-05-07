component extends="coldbox.system.testing.basetestcase"{
	function beforeAll(){
		super.beforeAll();
		super.setup();
	}


	function run(){
		describe("findStudentLevel should...",function(){
			beforeEach(function(){
				//lowestAmount = randrange(0,4);
				//writeDump(lowestAmount);
				//studentSkills = [];

				//for(var x = 1; x<randrange(1,100); x=x+1){
				//	studentSkills.append(createSkill(lowestAmount));
				//}

				//studentSkills = studentSkills.insertAt(randrange(1,studentSkills.len()),{"skillLevel":lowestAmount});
				//writeDump(studentSkills);
				//testObj = getInstance("students@ninja");
				//testme=testObj.findStudentLevel([]);
				//writeDump(testme);
			});
			it("return a number",function(){
				expect(true).tobeFalse();
				//expect(testme).toBeTypeOf("numeric");
			});
			it("By default it should return a 10",function(){
				expect(true).tobeFalse();
				//expect(testme).tobe(10);
			});
			it("When an array of skillLevels is submitted, return the lowest",function(){
				expect(true).tobeFalse();
				//testme=testObj.findStudentLevel(studentSkills);
				//expect(testme).tobe(lowestAmount);
			});
		});
	}

	function createSkill( lowest ){
		return {"skillLevel": randrange(lowest+1, lowest+100)};
	}
}
