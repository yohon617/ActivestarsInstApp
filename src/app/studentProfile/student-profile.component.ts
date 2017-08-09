import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Params } from '@angular/router';
import { Location } from '@angular/common';

import { Router } from '@angular/router';

import { ClassService } from './../services/class/class.service';
import { StudentService } from './../services/student/student.service';
import { Student } from './../models/student';
import { StudentRoster } from './../models/studentRoster';
import { School } from './../models/school';

@Component({
    selector: 'app-root',
    templateUrl: './student-profile.component.html',
    styleUrls: ['./student-profile.component.css']
})
export class StudentProfileComponent implements OnInit {

    student: Student = new Student();
    type: number = 0;
    schools: School[];

    constructor(
        private location: Location,
        private studentService: StudentService,
        private classService: ClassService,
        private route: ActivatedRoute,
        private router: Router
    ) { }

    ngOnInit(): void {
        //this.route.params
        //    .switchMap((params: Params) => this.studentService.getStudent(+params['id'], this.classService.SelectedClassWeek.ClassReportID))
        //    .subscribe(student => { this.student = student });

        this.route.params.subscribe(params => {
            if (+params['id'] > 0)
                this.studentService.getStudent(+params['id'], this.classService.SelectedClassWeek.ClassReportID)
                    .then(response => this.student = response);
            else
                this.student.ID = 0;
        });

        //0 = new
        //1 = transfer
        //2 = visiting
        this.type = +this.route.snapshot.paramMap.get('type');

        this.studentService.getSchools()
            .then(schools => this.schools = schools);

        //this.studentService.getStudent(12, this.classService.SelectedClassWeek.ClassReportID)
        //    .then(response => this.student = response);
    }

    public goBack() {
        this.location.back();
    }

    onSubmit() {
        if (this.student.ID == 0) {
            this.studentService.AddNewStudentToClass(this.student, this.classService.SelectedClassWeek.ClassReportID, this.student.ClassNumber,
                this.student.PayType, this.student.Status, this.type === 2, this.type === 1)
                .then(() => {
                    this.router.navigate(['/roster']);
                });
        }
        else {
            this.studentService.UpdateStudent(this.student)
                .then(() => {
                    this.router.navigate(['/roster']);
                });
        }
    }
}
