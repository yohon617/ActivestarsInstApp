import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Params } from '@angular/router';
import { Location } from '@angular/common';

import { ClassService } from './../services/class/class.service';
import { StudentService } from './../services/student/student.service';
import { Student } from './../models/student';
import { StudentRoster } from './../models/studentRoster';

@Component({
    selector: 'app-root',
    templateUrl: './student-profile.component.html',
    styleUrls: ['./student-profile.component.css']
})
export class StudentProfileComponent implements OnInit {

    student: Student;

    constructor(
        private location: Location,
        private studentService: StudentService,
        private classService: ClassService,
        private route: ActivatedRoute
    ) { }

    ngOnInit(): void {
        this.route.params
            .switchMap((params: Params) => this.studentService.getStudent(+params['id'], this.classService.SelectedClassWeek.ClassReportID))
            .subscribe(student => this.student = student);

        //this.studentService.getStudent(12, this.classService.SelectedClassWeek.ClassReportID)
        //    .then(response => this.student = response);
    }

    public goBack() {
        this.location.back();
    }
}
