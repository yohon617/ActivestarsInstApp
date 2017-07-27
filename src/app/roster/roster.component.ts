import { Component, OnInit } from '@angular/core';

import { Observable } from 'rxjs/Observable';
import { Subject } from 'rxjs/Subject';

import { ClassService } from './../services/class/class.service';
import { StudentService } from './../services/student/student.service';
import { Student } from './../models/student';
import { StudentRoster } from './../models/studentRoster';

@Component({
  selector: 'app-root',
  templateUrl: './roster.component.html',
  styleUrls: ['./roster.component.css']
})
export class RosterComponent implements OnInit {

    //studentList: StudentRoster[] = [];
    studentList: Observable<StudentRoster[]>;


    constructor(private studentService: StudentService, private classService: ClassService) { }

    ngOnInit(): void {
        //this.studentService.getStudentRosters(this.classService.SelectedClassWeek.ClassReportID)
        //    .then(rosters => {
        //        this.studentList = rosters;
        //    });

        this.studentList = this.classService.WeekChange
            .switchMap(
            () => this.studentService.getStudentRosters(this.classService.SelectedClassWeek.ClassReportID)
                
            );
    }

}
