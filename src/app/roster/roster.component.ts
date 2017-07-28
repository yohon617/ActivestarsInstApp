import { Component, OnInit, OnDestroy } from '@angular/core';

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
export class RosterComponent implements OnInit, OnDestroy {

    //studentList: StudentRoster[] = [];
    studentList: StudentRoster[];
    subscription: any;


    constructor(private studentService: StudentService, private classService: ClassService) { }

    ngOnInit(): void {
        this.subscription = this.classService.weekChange$.subscribe(() => {
            this.getStudentRosters();
        })

        if (this.classService.SelectedClassWeeks != null) {
            this.getStudentRosters();
        }
    }

    ngOnDestroy() {
        // TODO: is there a better way of doing this?
        this.subscription.unsubscribe();
    }

    getStudentRosters() {
           this.studentService.getStudentRosters(this.classService.SelectedClassWeek.ClassReportID).then(
                response => {
                    this.studentList = response;
                })        
    }


}
