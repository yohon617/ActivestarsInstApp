import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

import { StudentService } from './../services/student/student.service';

import { Student } from './../models/student';

@Component({
  selector: 'app-student-search',
  templateUrl: './student-search.component.html',
  styleUrls: ['./student-search.component.css']
})
export class StudentSearchComponent implements OnInit {

    public searchType: string = '';
    public firstName: string = '';
    public lastName: string = '';
    public aCode: string = '';
    public fCode: string = '';
    public sCode: string = '';
    public searchResults: Student[] = [];
    private showResult: boolean = false;

  constructor(private route: ActivatedRoute,
              private studentService: StudentService
  ) {}

  ngOnInit() {
      this.searchType = this.route.snapshot.paramMap.get('id');
  }

  public onSubmit() {
    
      this.studentService.searchStudent(this.firstName, this.lastName, this.aCode, this.fCode, this.sCode)
          .then(response => {
              console.log(response);
              this.searchResults = response.map(student => {
                  student['Status'] = '';
                  return student;
              });
              this.showResult = true;
          });
  }

}
