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
    checkedIn: boolean;
    student: Student;
    classFee: number;
    scholarshipFee: number;
    parentHelperFee: number;
    regFee: number;
    prepaidFee: number;
    checkInFee: number;
    makeUpFee: number = 0;
    totalFee: number;
    specialFee: number = 0;
    cashFee: number = 0;
    creditFee: number = 0;
    checkFee: number = 0;
    voucherFee: number = 0;
    absentWeekList: string[];
    madeUpWeekList: string[];
    timeToLoad: boolean = false;
    makeupWeeks: string = "";
    specialtyClasses: string = "";
    payType: string;
    testFee: number;
    testChecked: boolean = false;
    specFee1: number = 0;
    specFee2: number = 0;
    specFee3: number = 0;
    studentPIFWeeks: number = 0;

    constructor(
        private location: Location,
        private studentService: StudentService,
        private classService: ClassService,
        private route: ActivatedRoute
    ) { }

    ngOnInit(): void {

      this.checkedIn = (this.studentRoster.PayType != "") && this.studentRoster.PayType != "n/a" && this.studentRoster.PayType != "AB" ;
      
      this.studentService.getStudentPIFWeeks(this.classService.SelectedClassWeek.ClassReportID, this.studentRoster.StudentID)
        .then(response => {
          console.log("res: "+response);
          this.studentPIFWeeks = +response;
          //this.timeToLoad = true;
          //console.log(this.classService.SelectedClassWeek.ClassReportID);
          //console.log(this.studentRoster.StudentID);
          //console.log(this.studentPIFWeeks);

          if (!this.studentRoster.Scholarship && !this.studentRoster.ParentHelper) {
              switch (this.studentRoster.Status) {
                  case 1://regular
                  case 4://transfered
                      this.classFee = this.classService.SelectedClass.WeeklyFee;
                      if (this.classService.SelectedClassWeek.WeekNumber == 1)
                          this.prepaidFee = this.classService.SelectedClass.PrepaidFee;
                      else
                        this.prepaidFee = (this.classService.SelectedClass.PrepaidFee - this.classService.SelectedClass.RegFee) / (this.classService.SelectedClass.NumOfWeeks) * (this.studentPIFWeeks);
                      break;
                  case 2://advanced
                      this.classFee = this.classService.SelectedClass.WeeklyAdvancedFee;
                      if (this.classService.SelectedClassWeek.WeekNumber == 1)
                          this.prepaidFee = this.classService.SelectedClass.PrepaidAdvancedFee;
                      else
                        this.prepaidFee = (this.classService.SelectedClass.PrepaidAdvancedFee - this.classService.SelectedClass.RegFee) / (this.classService.SelectedClass.NumOfWeeks) * (this.studentPIFWeeks);
                      break;
                  case 5://extended
                      this.classFee = this.classService.SelectedClass.WeeklyExtendedFee;
                      if (this.classService.SelectedClassWeek.WeekNumber == 1)
                          this.prepaidFee = this.classService.SelectedClass.PrepaidExtendedFee;
                      else
                        this.prepaidFee = (this.classService.SelectedClass.PrepaidExtendedFee - this.classService.SelectedClass.RegFee) / (this.classService.SelectedClass.NumOfWeeks) * (this.studentPIFWeeks);
                      break;
                  default:
                      this.classFee = this.classService.SelectedClass.WeeklyFee;
                      if (this.classService.SelectedClassWeek.WeekNumber == 1)
                          this.prepaidFee = this.classService.SelectedClass.PrepaidFee;
                      else
                        this.prepaidFee = (this.classService.SelectedClass.PrepaidFee - this.classService.SelectedClass.RegFee) / (this.classService.SelectedClass.NumOfWeeks) * (this.studentPIFWeeks);
              }
              //console.log(this.classService.SelectedClass.PrepaidExtendedFee);
              this.specFee1 = this.classService.SelectedClass.Specialty1Fee;
              this.specFee2 = this.classService.SelectedClass.Specialty2Fee;
              this.specFee3 = this.classService.SelectedClass.Specialty3Fee;
              this.testFee = this.classService.SelectedClass.TestFee;
              this.regFee = this.classService.SelectedClass.RegFee + this.classFee;

          }
          else {
              this.classFee = 0;
              this.prepaidFee = 0;
              this.testFee = 0;
              this.regFee = 0;
          }

          this.scholarshipFee = this.classService.SelectedClass.ScholarshipFee;
          this.parentHelperFee = this.classService.SelectedClass.ParentHelperFee;

          if (this.isRegister) {
              this.cashFee = this.totalFee = this.checkInFee = this.regFee;
              this.payType = "REG";
          }
          else if (this.checkedIn) {
            this.cashFee = this.totalFee = this.checkInFee = 0;
            if (this.studentRoster.Scholarship)
              this.payType = "S";
            else if (this.studentRoster.ParentHelper)
              this.payType = "PH";
            else if (this.studentRoster.Prepaid)
              this.payType = this.studentRoster.PayType;
            else
              this.payType = "W";
          }
          else {
            if (!this.studentRoster.Prepaid) {
                this.cashFee = this.totalFee = this.checkInFee = this.classFee;
            }
            else {
                this.cashFee = this.totalFee = this.checkInFee = 0;
            }
            if (this.studentRoster.Scholarship)
                this.payType = "S";
            else if (this.studentRoster.ParentHelper)
                this.payType = "PH";
            else if (this.studentRoster.Prepaid)
              this.payType = "P";
            else
              this.payType = "W";
          }
          this.studentService.getStudentRosterABWeeks(this.studentRoster.StudentID, this.classService.SelectedClassWeek.ClassReportID)
              .then(response => {
                this.absentWeekList = response.split(",");
                if (!this.checkedIn)
                  this.timeToLoad = true;
                else {

                  this.studentService.getStudentRosterMadeUpWeeks(this.studentRoster.StudentID, this.classService.SelectedClassWeek.ClassReportID)
                    .then(response => {
                      this.madeUpWeekList = response.split(",");
                      this.timeToLoad = true;
                      console.log(this.madeUpWeekList.length);
                      console.log(this.madeUpWeekList);
                    }
                  );
                }
              }
          );
          //this.route.params
          //    .switchMap((params: Params) => this.studentService.getStudent(+params['id'], this.classService.SelectedClassWeek.ClassReportID))
          //    .subscribe(student => this.student = student);

            //        this.classService.SelectedClass.Specialty1Desc
        }
      );
    }

    checkRegFee(e) {
      this.payType = e.target.value;
      if (e.target.value == "REG") {
          this.checkInFee -= this.prepaidFee;
          this.checkInFee += this.regFee;
          this.cashFee = this.totalFee = this.checkInFee + this.specialFee;
      }
      else {//PIF
          this.checkInFee -= this.regFee;
          this.checkInFee += this.prepaidFee;
          this.cashFee = this.totalFee = this.checkInFee + this.specialFee;
      }
    }

    checkWeeklyFee(e) {
      if (e.target.value == 'PIF') {
          this.checkInFee -= this.classFee;
          this.checkInFee += this.prepaidFee;
      }
      else {
          this.checkInFee += this.classFee;
          this.checkInFee -= this.prepaidFee;
      }
      this.payType = e.target.value;
      this.cashFee = this.totalFee = this.checkInFee + this.makeUpFee + this.specialFee;
      this.creditFee = this.checkFee = this.voucherFee = 0;
    }

    checkScholarshipFee(e) {
    }

    checkParentHelperFee(e) {
    }

    checkTestFee(e) {
      if (e.target.checked) {
          this.checkInFee += this.testFee;
          this.testChecked = true;
      }
      else {
          this.checkInFee -= this.testFee;
          this.testChecked = false;
      }
      this.cashFee = this.totalFee = this.checkInFee + this.makeUpFee + this.specialFee;
      this.creditFee = this.checkFee = this.voucherFee = 0;
    }

    checkMakeUpFee(e) {
      if (e.target.checked) {
          this.makeUpFee += (this.studentRoster.Prepaid || this.payType == "PIF") ? 0 : this.classFee;
          this.makeupWeeks += "," + e.target.value;
      }
      else {
          this.makeUpFee -= (this.studentRoster.Prepaid || this.payType == "PIF") ? 0 : this.classFee;
          this.makeupWeeks = this.makeupWeeks.replace("," + e.target.value, "")
      }
      this.cashFee = this.totalFee = this.checkInFee + ((this.studentRoster.Prepaid || this.payType == "PIF") ? 0 : this.makeUpFee) + this.specialFee;
      this.creditFee = 0;
      this.checkFee = 0;
      this.voucherFee = 0;
      if (this.makeupWeeks.length > 0)
        console.log(this.makeupWeeks.substring(1));
    }

    changeSpecialFee(e) {
      this.specialFee = +e.target.value;
      this.cashFee = this.totalFee = this.checkInFee + this.makeUpFee + this.specialFee;
      this.creditFee = 0;
      this.checkFee = 0;
      this.voucherFee = 0;
    }

    checkSpec(e, specClassNum) {
      if (e.target.checked) {
          if (!this.studentRoster.Scholarship && !this.studentRoster.ParentHelper) {
              this.specialFee += +e.target.value;
          }
          this.specialtyClasses += "," + specClassNum;
      }
      else {
          if (!this.studentRoster.Scholarship && !this.studentRoster.ParentHelper) {
              this.specialFee -= +e.target.value;
          }
          this.specialtyClasses = this.specialtyClasses.replace("," + specClassNum, "")
      }
      this.cashFee = this.totalFee = this.checkInFee + this.makeUpFee + this.specialFee;
      this.creditFee = 0;
      this.checkFee = 0;
      this.voucherFee = 0;

        if (this.specialtyClasses.length > 0)
            console.log(this.specialtyClasses.substring(1));
    }

    creditFeeUpdate(e) {
      if (e.target.value == "" || isNaN(e.target.value)) {
        this.creditFee = e.target.value = 0;
        this.cashFee = this.totalFee - this.voucherFee - this.checkFee;
      }
      else if ((+this.voucherFee + +this.checkFee + +e.target.value) > this.totalFee) {
        this.creditFee = e.target.value = 0;
        this.cashFee = this.totalFee - this.voucherFee - this.checkFee;
      }
      else {
        this.cashFee = this.totalFee - e.target.value - this.voucherFee - this.checkFee;
        this.creditFee = e.target.value;
      }
    }

    checkFeeUpdate(e) {
      if (e.target.value == "" || isNaN(e.target.value)) {
        this.checkFee = e.target.value = 0;
        this.cashFee = this.totalFee - this.voucherFee - this.creditFee;
      }
      else if ((+this.voucherFee + +this.creditFee + +e.target.value) > this.totalFee) {
        this.checkFee = e.target.value = 0;
        this.cashFee = this.totalFee - this.voucherFee - this.creditFee;
      }
      else {
        this.cashFee = this.totalFee - e.target.value - this.voucherFee - this.creditFee;
        this.checkFee = e.target.value;
      }
    }

    voucherFeeUpdate(e) {
      if (e.target.value == "" || isNaN(e.target.value)) {
        this.voucherFee = e.target.value = 0;
        this.cashFee = this.totalFee - this.creditFee - this.checkFee;
      }
      else if ((+this.creditFee + +this.checkFee + +e.target.value) > this.totalFee) {
        this.voucherFee = e.target.value = 0;
        this.cashFee = this.totalFee - this.creditFee - this.checkFee;
      }
      else {
        this.cashFee = this.totalFee - e.target.value - this.creditFee - this.checkFee;
        this.voucherFee = e.target.value;
      }
    }

  fillAllFee(type) {
      switch (type) {
        case 1: {
          this.creditFee = this.checkFee = this.voucherFee = 0;
          this.cashFee = this.totalFee;
          break;
        }
        case 2: {
          this.cashFee = this.checkFee = this.voucherFee = 0;
          this.creditFee = this.totalFee;
          break;
        }
        case 3: {
          this.creditFee = this.cashFee = this.voucherFee = 0;
          this.checkFee = this.totalFee;
          break;
        }
        case 4: {
          this.creditFee = this.checkFee = this.cashFee = 0;
          this.voucherFee = this.totalFee;
          break;
        }
      }
      return false;
    }

    checkInClick() {
      if (this.makeupWeeks.length > 0)
          this.makeupWeeks = this.makeupWeeks.substring(1);
      if (this.specialtyClasses.length > 0)
        this.specialtyClasses = this.specialtyClasses.substring(1);

      if (!this.checkedIn) {
        this.studentService.CheckInStudent(this.studentRoster.StudentID, this.classService.SelectedClassWeek.ClassReportID, this.payType, this.specialFee, this.checkInFee + this.makeUpFee, this.makeupWeeks, this.cashFee, this.creditFee, this.checkFee, this.voucherFee, this.testChecked, this.prepaidFee, this.specialtyClasses)
          .then(() => {
            this.refreshRoster.emit();
            this.modalRef.hide();
          });
      }
      else {
        this.studentService.UpdateCheckInStudent(this.studentRoster.StudentID, this.classService.SelectedClassWeek.ClassReportID, this.payType, this.specialFee, this.makeUpFee, this.makeupWeeks, this.cashFee, this.creditFee, this.checkFee, this.voucherFee, this.testChecked, this.specialtyClasses, this.madeUpWeekList)
          .then(() => {
            this.refreshRoster.emit();
            this.modalRef.hide();
          });

      }
    }
}
