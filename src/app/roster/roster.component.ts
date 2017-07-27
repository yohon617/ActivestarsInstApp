import { Component, OnInit } from '@angular/core';

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

    studentList: StudentRoster[] = [];

    constructor(private studentService: StudentService, private classService: ClassService) { }

    ngOnInit(): void {
        this.studentService.getStudentRosters(this.classService.SelectedClassWeek.ClassReportID)
            .then(rosters => {
                this.studentList = rosters;
            });
    }

}
