import { Component, OnInit } from '@angular/core';

import { StudentService } from './../services/student/student.service';

@Component({
  selector: 'app-student-search',
  templateUrl: './student-search.component.html',
  styleUrls: ['./student-search.component.css']
})
export class StudentSearchComponent implements OnInit {

  public firstName: string = '';
  public lastName: string = '';
  public aCode: string;
  public fCode: string;
  public sCode: string;

  constructor(private studentService: StudentService) {
  }

  ngOnInit() {
  }

  onSubmit() {
    
      this.studentService.searchStudent(this.firstName, this.lastName, this.aCode, this.fCode, this.sCode)
        .then(response => console.log(response));
  }

}
