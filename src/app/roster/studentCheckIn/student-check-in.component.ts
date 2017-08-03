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
    @Input() isRegister: boolean;
    @Output() refreshRoster = new EventEmitter();
    student: Student;
    classFee: number;
    regFee: number;
    prepaidFee: number;
    checkInFee: number;
    makeUpFee: number = 0;
    totalFee: number;
    specialFee: number = 0;
    cashCreditFee: number = 0;
    voucherFee: number = 0;
    absentWeekList: string[];
    timeToLoad: boolean = false;
    makeupWeeks: string = "";
    payType: string;

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
                this.prepaidFee = this.classService.SelectedClass.PrepaidFee;
                break;
            case 2://advanced
                this.classFee = this.classService.SelectedClass.WeeklyAdvancedFee;
                this.prepaidFee = this.classService.SelectedClass.PrepaidAdvancedFee;
                break;
            case 5://extended
                this.classFee = this.classService.SelectedClass.WeeklyExtendedFee;
                this.prepaidFee = this.classService.SelectedClass.PrepaidExtendedFee;
                break;
            default:
                this.classFee = this.classService.SelectedClass.WeeklyFee;
                this.prepaidFee = this.classService.SelectedClass.PrepaidFee;
        }

        this.regFee = this.classService.SelectedClass.RegFee + this.classFee;
        if (this.isRegister) {
            this.cashCreditFee = this.totalFee = this.checkInFee = this.regFee;
            this.payType = "REG";
        }
        else {
            this.totalFee = this.totalFee = this.checkInFee = 0;
            if (this.studentRoster.Prepaid)
              this.payType = "P";
            else
              this.payType = "W";
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

    checkRegFee(e) {
        this.payType = e.target.value;
        if (e.target.value == "REG") {
            this.checkInFee -= this.prepaidFee;
            this.checkInFee += this.regFee;
            this.cashCreditFee = this.totalFee = this.checkInFee + this.specialFee;
        }
        else {//PIF
            this.checkInFee -= this.regFee;
            this.checkInFee += this.prepaidFee;
            this.cashCreditFee = this.totalFee = this.checkInFee + this.specialFee;
        }
    }

    checkWeeklyFee(e) {
        if (e.target.checked) {
            this.checkInFee += this.classFee;
        }
        else {
            this.checkInFee -= this.classFee;
        }
        this.cashCreditFee = this.totalFee = this.checkInFee + this.makeUpFee + this.specialFee;
        this.voucherFee = 0;
    }

    checkMakeUpFee(e) {
        if (e.target.checked) {
            this.makeUpFee += this.classFee;
            this.makeupWeeks += "," + e.target.value;
        }
        else {
            this.makeUpFee -= this.classFee;
            this.makeupWeeks = this.makeupWeeks.replace("," + e.target.value, "")
        }
        this.cashCreditFee = this.totalFee = this.checkInFee + this.makeUpFee + this.specialFee;
        this.voucherFee = 0;
        if (this.makeupWeeks.length > 0)
            console.log(this.makeupWeeks.substring(1));
    }

    changeSpecialFee(e) {
        this.specialFee = +e.target.value;
        this.cashCreditFee = this.totalFee = this.checkInFee + this.makeUpFee + this.specialFee;
        this.voucherFee = 0;
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
        if (this.makeupWeeks.length > 0)
            this.makeupWeeks = this.makeupWeeks.substring(1);
        this.studentService.CheckInStudent(this.studentRoster.StudentID, this.classService.SelectedClassWeek.ClassReportID, this.payType, this.specialFee, this.checkInFee + this.makeUpFee, this.makeupWeeks)
            .then(() => {
              this.refreshRoster.emit();
              this.modalRef.hide();
            });
    }
}
