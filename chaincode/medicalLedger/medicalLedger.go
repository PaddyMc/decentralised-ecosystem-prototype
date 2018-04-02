package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	// "strconv"

	"github.com/hyperledger/fabric/core/chaincode/shim"
	sc "github.com/hyperledger/fabric/protos/peer"
)

type SmartContract struct {
}

type MedicalRecord struct {
	Name   string `json:"name"`
	Image  string `json:"image"`
	Record string `json:"record"`
}

func (s *SmartContract) Init(APIstub shim.ChaincodeStubInterface) sc.Response {
	return shim.Success(nil)
}

func (s *SmartContract) Invoke(APIstub shim.ChaincodeStubInterface) sc.Response {

	function, args := APIstub.GetFunctionAndParameters()

	if function == "getMedicalRecord" {
		return s.getMedicalRecord(APIstub, args)
	} else if function == "initLedger" {
		return s.initLedger(APIstub)
	} else if function == "addMedicalRecord" {
		return s.addMedicalRecord(APIstub, args)
	} else if function == "queryAllMedicalRecords" {
		return s.queryAllMedicalRecords(APIstub)
	} else if function == "updateMedicalRecord" {
		return s.updateMedicalRecord(APIstub, args)
	}

	return shim.Error("Invalid Smart Contract function name.")
}

func (s *SmartContract) getMedicalRecord(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {

	if len(args) != 1 {
		return shim.Error("Incorrect number of arguments. Expecting 1")
	}

	medicalRecordAsBytes, _ := APIstub.GetState(args[0])
	return shim.Success(medicalRecordAsBytes)
}

func (s *SmartContract) initLedger(APIstub shim.ChaincodeStubInterface) sc.Response {
	medicalRecords := []MedicalRecord{
		MedicalRecord{Name: "Cael", Image: "cccccccccc", Record: "Bubonic Plague"},
		MedicalRecord{Name: "Patches", Image: "pppppppppp", Record: "Smallpox"},
	}

	medicalRecordAsBytes, _ := json.Marshal(medicalRecords[0])
	APIstub.PutState("Cael", medicalRecordAsBytes)
	fmt.Println("Added", medicalRecords[0])

	medicalRecordAsBytes, _ = json.Marshal(medicalRecords[1])
	APIstub.PutState("Patches", medicalRecordAsBytes)
	fmt.Println("Added", medicalRecords[1])

	return shim.Success(nil)
}

func (s *SmartContract) addMedicalRecord(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {

	if len(args) != 4 {
		return shim.Error("Incorrect number of arguments. Expecting 4")
	}

	var medicalRecord = MedicalRecord{Name: args[1], Image: args[2], Record: args[3]}

	medicalRecordAsBytes, _ := json.Marshal(medicalRecord)
	APIstub.PutState(args[0], medicalRecordAsBytes)

	return shim.Success(nil)
}

func (s *SmartContract) queryAllMedicalRecords(APIstub shim.ChaincodeStubInterface) sc.Response {

	startKey := "MedicalRecord0"
	endKey := "MedicalRecord999"

	resultsIterator, err := APIstub.GetStateByRange(startKey, endKey)
	if err != nil {
		return shim.Error(err.Error())
	}
	defer resultsIterator.Close()

	var buffer bytes.Buffer
	buffer.WriteString("[")

	bArrayMemberAlreadyWritten := false
	for resultsIterator.HasNext() {
		queryResponse, err := resultsIterator.Next()
		if err != nil {
			return shim.Error(err.Error())
		}
		if bArrayMemberAlreadyWritten == true {
			buffer.WriteString(",")
		}
		buffer.WriteString("{\"Key\":")
		buffer.WriteString("\"")
		buffer.WriteString(queryResponse.Key)
		buffer.WriteString("\"")

		buffer.WriteString(", \"Record\":")
		buffer.WriteString(string(queryResponse.Value))
		buffer.WriteString("}")
		bArrayMemberAlreadyWritten = true
	}
	buffer.WriteString("]")

	fmt.Printf("- queryAllMedicalRecords:\n%s\n", buffer.String())

	return shim.Success(buffer.Bytes())
}

func (s *SmartContract) updateMedicalRecord(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {

	if len(args) != 2 {
		return shim.Error("Incorrect number of arguments. Expecting 2")
	}

	medicalRecordAsBytes, _ := APIstub.GetState(args[0])
	medicalRecord := MedicalRecord{}

	json.Unmarshal(medicalRecordAsBytes, &medicalRecord)
	medicalRecord.Record = args[1]

	medicalRecordAsBytes, _ = json.Marshal(medicalRecord)
	APIstub.PutState(args[0], medicalRecordAsBytes)

	return shim.Success(nil)
}

func main() {

	err := shim.Start(new(SmartContract))
	if err != nil {
		fmt.Printf("Error creating new Smart Contract: %s", err)
	}
}
