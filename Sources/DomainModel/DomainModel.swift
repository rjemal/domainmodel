struct DomainModel {
    var text = "Hello, World!"
        // Leave this here; this value is also tested in the tests,
        // and serves to make sure that everything is working correctly
        // in the testing harness and framework.
}

////////////////////////////////////
// Money
//

public struct Money {
    var amount: Int
    var currency: String
    init(amount:Int, currency:String) {
           self.amount = amount
           self.currency = currency
       }
    func convert(_ c: String) -> Money {
        
        var total =  Money(amount: amount, currency: c)
        switch self.currency {
            case "CAN":
                total.amount = Int(Double(self.amount) / 1.25)
            case "EUR":
                total.amount = Int(Double(self.amount) / 1.5)
            case "GBP":
                total.amount = self.amount * 2
            default:
                total.amount = self.amount
            }
        switch c {
            case "CAN":
                total.amount = Int(Double(total.amount) * 1.25)
            case "EUR":
                total.amount = Int(Double(total.amount) * 1.5)
            case "GBP":
                total.amount = Int(Double(total.amount) * 0.5)
            default:
                break
            }
            return total

            }
        
        func add(_ m: Money) -> Money {
                let m1 = self.convert(m.currency)
                let total = Money(amount: m1.amount + m.amount, currency: m.currency)
                return total
            }
        
        func subtract(_ m: Money) -> Money {
                let m1 = self.convert(m.currency)
                let total = Money(amount: m1.amount - m.amount, currency: m.currency)
                return total
            }
           
}
    

////////////////////////////////////
// Job
//
public class Job {
    public enum JobType {
        case Hourly(Double)
        case Salary(UInt)
    }
    
    var type: JobType
    var title: String
    
    init(title x: String, type y: JobType) {
           title = x
           type = y
       }
    
    func calculateIncome(_ hours: Int) -> Int {
            switch self.type {
            case .Hourly(let pay):
                return Int(pay * Double(hours))
            case .Salary(let salary):
                return Int(salary)
            }
        }
    
    func raise(byAmount: Double) {
            switch self.type {
            case .Hourly(let pay):
                self.type = JobType.Hourly(pay + byAmount)
            case .Salary(let yearly_pay):
                self.type = JobType.Salary(yearly_pay + UInt((Double(byAmount))))
            }
        }
    
    func raise(byPercent: Double) {
            switch self.type {
            case .Hourly (let pay):
                self.type = JobType.Hourly(pay + (pay * byPercent))
            case .Salary (let yearly_pay):
                self.type = JobType.Salary(yearly_pay + (UInt)((Double(yearly_pay) * byPercent)))
            }
        }
    

        
    
}


////////////////////////////////////
// Person
//


public class Person {
    var firstName: String
    var lastName: String
    var age: Int
    var job: Job?{
        didSet{
            if age < 16 {
                job = nil
            }
        }
    }
    
    var spouse: Person? {
            didSet{
                if age < 16 {
                    spouse = nil
                }
            }
        }
    
    init(firstName first: String, lastName last: String, age: Int) {
        firstName = first
        lastName = last
        self.age = age
        }
    
    func toString() -> String {
            return String ("[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(job) spouse:\(spouse)]")
        }
    
}

////////////////////////////////////
// Family
//


public class Family {
    var members: [Person] = []
    init(spouse1: Person, spouse2: Person) {
            if (spouse1.spouse == nil && spouse2.spouse == nil) {
                members.append(spouse1)
                spouse1.spouse = spouse2
                members.append(spouse2)
                spouse2.spouse = spouse1
            }
        }
        
    func haveChild(_ children: Person) -> Bool {
            if members[0].age > 30 || members[1].age > 30 {
                members.append(children)
                return true
            }
            return false
        }
    
    func householdIncome() -> Int {
           var amount = 0
           for member in self.members {
                if(member.job != nil){
                amount += member.job?.calculateIncome(2000) ?? 0
                }
           }
           return amount
       }
}

