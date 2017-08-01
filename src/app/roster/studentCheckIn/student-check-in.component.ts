import { Component, OnInit, EventEmitter, Input, Output } from '@angular/core';
import { ActivatedRoute, Params } from '@angular/router';
import { Location } from '@angular/common';

import { BsModalRef } from 'ngx-bootstrap/modal/modal-options.class';

import { ClassService } from './../../services/class/class.service';
import { StudentService } from './../../services/student/student.service';
import { Student } from './../../models/student';
import { StudentRoster } from './../../models/studentRoster';

@Component({
    selector: 'student-check-in',
    templateUrl: './student-check-in.component.html',
    styleUrls: ['./student-check-in.component.css']
})
export class StudentCheckInComponent implements OnInit {

    @Input() modalRef: BsModalRef;
    @Input() studentRoster: StudentRoster;
    @Output() refreshRoster = new EventEmitter();
    student: Student;
    classFee: number;
    totalFee: number = 0;
    cashCreditFee: number = 0;
    voucherFee: number = 0;
    absentWeekList: string[];
    timeToLoad: boolean = false;
    makeupWeeks: string = "";

    constructor(
        private location: Location,
        private studentService: StudentService,
        private classService: ClassService,
        private route: ActivatedRoute
    ) { }

    ngOnInit(): void {
        switch (this.studentRoster.Status) {
            case 1://regular
            case 4://transfered
                this.classFee = this.classService.SelectedClass.WeeklyFee;
                break;
            case 2://advanced
                this.classFee = this.classService.SelectedClass.WeeklyAdvancedFee;
                break;
            case 5://extended
                this.classFee = this.classService.SelectedClass.WeeklyExtendedFee;
                break;
            default:
                this.classFee = this.classService.SelectedClass.WeeklyFee; 
        }
        
        this.studentService.getStudentRosterABWeeks(this.studentRoster.StudentID, this.classService.SelectedClassWeek.ClassReportID)
            .then(response => {
                this.absentWeekList = response.split(",");
                this.timeToLoad = true;
            }
            );
        //this.route.params
        //    .switchMap((params: Params) => this.studentService.getStudent(+params['id'], this.classService.SelectedClassWeek.ClassReportID))
        //    .subscribe(student => this.student = student);
    }

    checkWeeklyFee(e) {
        if (e.target.checked) {
            this.totalFee += this.classFee;
        }
        else {
            this.totalFee -= this.classFee;
        }
        this.cashCreditFee = this.totalFee;
        this.voucherFee = 0;
    }

    checkMakeUpFee(e) {
        if (e.target.checked) {
            this.totalFee += this.classFee;
            this.makeupWeeks += "," + e.target.value;
        }
        else {
            this.totalFee -= this.classFee;
            this.makeupWeeks = this.makeupWeeks.replace("," + e.target.value, "")
        }
        this.cashCreditFee = this.totalFee;
        this.voucherFee = 0;
        console.log(this.makeupWeeks);
    }

    voucherFeeUpdate(e) {
        if (e.target.value == "" || isNaN(e.target.value)) {
            this.voucherFee = e.target.value = 0;
            this.cashCreditFee = this.totalFee;
        }
        else if (e.target.value > this.totalFee) {
            this.voucherFee = e.target.value = 0;
            this.cashCreditFee = this.totalFee;
        }
        else {
            this.cashCreditFee = this.totalFee - e.target.value;
            this.voucherFee = e.target.value;
        }
    }

    checkInClick() {
        this.studentService.CheckInStudent(this.studentRoster.StudentID, this.classService.SelectedClassWeek.ClassReportID, 'W', 0, this.makeupWeeks);
        this.modalRef.hide();
        this.refreshRoster.emit();
        console.log(this.voucherFee);
    }
}
