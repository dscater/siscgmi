<template>
    <div class="row">
        <div class="col-md-12">
            <form>
                <div class="row">
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.codificacion,
                            }"
                            >Codificación*</label
                        >
                        <el-input
                            placeholder="Codificación"
                            :class="{
                                'is-invalid': errors.codificacion,
                            }"
                            v-model="oPlanMantenimiento.codificacion"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.codificacion"
                            v-text="errors.codificacion[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.subunidad_id,
                            }"
                            >Seleccionar Subunidad*</label
                        >
                        <el-select
                            placeholder="Seleccionar Subunidad"
                            class="w-100"
                            :class="{
                                'is-invalid': errors.subunidad_id,
                            }"
                            v-model="oPlanMantenimiento.subunidad_id"
                            clearable
                        >
                            <el-option
                                v-for="item in listSubunidads"
                                :key="item.id"
                                :value="item.id"
                                :label="item.full_name"
                            ></el-option>
                        </el-select>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.subunidad_id"
                            v-text="errors.subunidad_id[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.gama_id,
                            }"
                            >Seleccionar Gama de Mantenimiento*</label
                        >
                        <el-select
                            placeholder="Seleccionar Gama de Mantenimiento"
                            class="w-100"
                            :class="{
                                'is-invalid': errors.gama_id,
                            }"
                            v-model="oPlanMantenimiento.gama_id"
                            @change="getTiempoGama"
                            clearable
                        >
                            <el-option
                                v-for="item in listGamaMantenimientos"
                                :key="item.id"
                                :value="item.id"
                                :label="item.full_name"
                            ></el-option>
                        </el-select>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.gama_id"
                            v-text="errors.gama_id[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.pm,
                            }"
                            >PM*</label
                        >
                        <el-input
                            placeholder="PM"
                            :class="{
                                'is-invalid': errors.pm,
                            }"
                            v-model="oPlanMantenimiento.pm"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.pm"
                            v-text="errors.pm[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.prioridad,
                            }"
                            >Prioridad*</label
                        >
                        <el-select
                            placeholder="Prioridad"
                            class="w-100"
                            :class="{
                                'is-invalid': errors.prioridad,
                            }"
                            v-model="oPlanMantenimiento.prioridad"
                            clearable
                        >
                            <el-option
                                v-for="(item, index) in listPrioridads"
                                :key="index"
                                :value="item"
                                :label="item"
                            ></el-option>
                        </el-select>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.prioridad"
                            v-text="errors.prioridad[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.tiempo,
                            }"
                            >Tiempo estimado*</label
                        >
                        <input
                            placeholder="Tiempo estimado"
                            type="number"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.tiempo,
                            }"
                            v-model="oPlanMantenimiento.tiempo"
                            clearable
                            readonly
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.tiempo"
                            v-text="errors.tiempo[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.dias,
                            }"
                            >Días estimados para terminar</label
                        >
                        <input
                            placeholder="Días estimados para terminar"
                            type="number"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.dias,
                            }"
                            v-model="oPlanMantenimiento.dias"
                            clearable
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.dias"
                            v-text="errors.dias[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.tipo_mantenimiento,
                            }"
                            >Tipo Mantenimiento*</label
                        >
                        <el-select
                            placeholder="Tipo Mantenimiento"
                            class="w-100"
                            :class="{
                                'is-invalid': errors.tipo_mantenimiento,
                            }"
                            v-model="oPlanMantenimiento.tipo_mantenimiento"
                            clearable
                        >
                            <el-option
                                v-for="(item, index) in listTipoMantenimientos"
                                :key="index"
                                :value="item"
                                :label="item"
                            ></el-option>
                        </el-select>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.tipo_mantenimiento"
                            v-text="errors.tipo_mantenimiento[0]"
                        ></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <h3 class="card-title font-weight-bold">
                            DATOS DE HISTORIAL
                        </h3>
                    </div>
                    <hr class="col-md-12" />
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.ultima_fecha_programada,
                            }"
                            >Última Fecha Programada</label
                        >
                        <input
                            type="date"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.ultima_fecha_programada,
                            }"
                            v-model="oPlanMantenimiento.ultima_fecha_programada"
                            clearable
                            @change="getPlanProgramacion"
                            @keyup="getPlanProgramacion"
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.ultima_fecha_programada"
                            v-text="errors.ultima_fecha_programada[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.ultima_fecha_terminada,
                            }"
                            >Última Fecha Terminada</label
                        >
                        <input
                            type="date"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.ultima_fecha_terminada,
                            }"
                            v-model="oPlanMantenimiento.ultima_fecha_terminada"
                            clearable
                            @change="getPlanProgramacion"
                            @keyup="getPlanProgramacion"
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.ultima_fecha_terminada"
                            v-text="errors.ultima_fecha_terminada[0]"
                        ></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <h3 class="card-title font-weight-bold">
                            PROGRAMACIÓN
                        </h3>
                    </div>
                    <hr class="col-md-12" />
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.programacion,
                            }"
                            >Programación*</label
                        >
                        <el-select
                            placeholder="Programación"
                            class="w-100"
                            :class="{
                                'is-invalid': errors.programacion,
                            }"
                            v-model="oPlanMantenimiento.programacion"
                            clearable
                            @change="getPlanProgramacion"
                        >
                            <el-option
                                v-for="(item, index) in listProgramacions"
                                :key="index"
                                :value="item"
                                :label="item"
                            ></el-option>
                        </el-select>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.programacion"
                            v-text="errors.programacion[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.fecha_final,
                            }"
                            >Fecha Final de Programación*</label
                        >
                        <input
                            type="date"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.fecha_final,
                            }"
                            v-model="oPlanMantenimiento.fecha_final"
                            clearable
                            @change="getPlanProgramacion"
                            @keyup="getPlanProgramacion"
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.fecha_final"
                            v-text="errors.fecha_final[0]"
                        ></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <h3 class="card-title font-weight-bold">
                            FRECUENCIA DE MANTENIMIENTO
                        </h3>
                    </div>
                    <hr class="col-md-12" />
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.variable_control_id,
                            }"
                            >Seleccionar Variable de Control*</label
                        >
                        <el-select
                            placeholder="Seleccionar Variable de Control"
                            class="w-100"
                            :class="{
                                'is-invalid': errors.variable_control_id,
                            }"
                            v-model="oPlanMantenimiento.variable_control_id"
                            clearable
                            @change="
                                getPlanProgramacion();
                                getFrecuencias();
                            "
                        >
                            <el-option
                                v-for="item in listVariableControls"
                                :key="item.id"
                                :value="item.id"
                                :label="item.full_name"
                            ></el-option>
                        </el-select>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.variable_control_id"
                            v-text="errors.variable_control_id[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.frecuencia_id,
                            }"
                            >Seleccionar Frecuencia*</label
                        >
                        <el-select
                            placeholder="Seleccionar Frecuencia"
                            class="w-100"
                            :class="{
                                'is-invalid': errors.frecuencia_id,
                            }"
                            v-model="oPlanMantenimiento.frecuencia_id"
                            clearable
                            @change="getPlanProgramacion"
                        >
                            <el-option
                                v-for="item in listFrecuencias"
                                :key="item.id"
                                :value="item.id"
                                :label="item.frecuencia"
                            ></el-option>
                        </el-select>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.frecuencia_id"
                            v-text="errors.frecuencia_id[0]"
                        ></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <h3 class="card-title font-weight-bold">
                            PLAN DE PROGRAMACIÓN
                        </h3>
                    </div>
                    <hr class="col-md-12" />
                    <b-skeleton-wrapper :loading="loading" class="w-100">
                        <template #loading>
                            <b-skeleton-table
                                :rows="3"
                                :columns="3"
                                :table-props="{ bordered: true, striped: true }"
                            >
                            </b-skeleton-table>
                        </template>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Número de mantenimiento</th>
                                    <th>Días</th>
                                    <th>Fecha</th>
                                </tr>
                            </thead>
                            <tbody>
                                <template
                                    v-if="
                                        oPlanMantenimiento.programacions
                                            .length > 0
                                    "
                                >
                                    <tr
                                        v-for="(
                                            item, index
                                        ) in oPlanMantenimiento.programacions"
                                    >
                                        <td>{{ item.numero }}</td>
                                        <td>{{ item.dias }}</td>
                                        <td>{{ item.fecha }}</td>
                                    </tr>
                                </template>
                                <template v-else>
                                    <tr>
                                        <td colspan="3" class="text-center">
                                            NO SE CARGÓ LA INFORMACIÓN NECESARIA
                                        </td>
                                    </tr>
                                </template>
                            </tbody>
                        </table>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.programacions"
                            v-text="errors.programacions[0]"
                        ></span>
                    </b-skeleton-wrapper>
                </div>
                <div class="row">
                    <div class="col-md-3">
                        <el-button
                            type="primary"
                            class="bg-primary"
                            :loading="enviando"
                            @click="setRegistro()"
                            >{{ textoBoton }}</el-button
                        >
                    </div>
                </div>
            </form>
        </div>
    </div>
</template>

<script>
export default {
    props: {
        muestra_modal: {
            type: Boolean,
            default: false,
        },
        accion: {
            type: String,
            default: "nuevo",
        },
        plan_mantenimiento: {
            type: Object,
            default: {
                id: 0,
                codificacion: "",
                subunidad_id: "",
                gama_id: "",
                pm: "",
                prioridad: "",
                tiempo: "",
                dias: "",
                tipo_mantenimiento: "",
                ultima_fecha_programada: "",
                ultima_fecha_terminada: "",
                programacion: "",
                fecha_final: "",
                variable_control_id: "",
                frecuencia_id: "",
                programacions: [],
            },
        },
    },
    watch: {
        muestra_modal: function (newVal, oldVal) {
            this.errors = [];
            if (newVal) {
                this.bModal = true;
            } else {
                this.bModal = false;
            }
        },
        plan_mantenimiento(newVal) {
            this.oPlanMantenimiento = newVal;
        },
    },
    computed: {
        textoBoton() {
            if (this.accion == "nuevo") {
                return "Registrar";
            } else {
                return "Actualizar";
            }
        },
    },
    data() {
        return {
            user: JSON.parse(localStorage.getItem("user")),
            bModal: this.muestra_modal,
            enviando: false,
            loading: true,
            errors: [],
            oPlanMantenimiento: this.plan_mantenimiento,
            listSubunidads: [],
            listGamaMantenimientos: [],
            listVariableControls: [],
            listFrecuencias: [],
            listPrioridads: ["URGENTE", "MODERADO", "LEVE"],
            listTipoMantenimientos: [
                "PREVENTIVO",
                "PREDICTIVO",
                "INSPECCIÓN",
                "LUBRICACIÓN",
            ],
            listProgramacions: [
                "ÚLTIMA VEZ QUE SE PROGRAMÓ",
                "ÚLTIMA VEZ QUE SE TERMINÓ",
            ],
        };
    },
    mounted() {
        this.bModal = this.muestra_modal;
        let self = this;
        setTimeout(() => {
            self.loading = false;
        }, 500);
        this.getSubunidads();
        this.getGamaMantenimientos();
        this.getVariableControls();
    },
    methods: {
        getSubunidads() {
            axios.get("/admin/subunidads").then((response) => {
                this.listSubunidads = response.data.subunidads;
            });
        },
        getGamaMantenimientos() {
            axios.get("/admin/gama_mantenimientos").then((response) => {
                this.listGamaMantenimientos = response.data.gama_mantenimientos;
            });
        },
        getVariableControls() {
            axios.get("/admin/variable_controls").then((response) => {
                this.listVariableControls = response.data.variable_controls;
            });
        },
        getFrecuencias() {
            if (this.oPlanMantenimiento.variable_control_id != "") {
                axios
                    .get("/admin/frecuencias/getByVariableControl", {
                        params: {
                            id: this.oPlanMantenimiento.variable_control_id,
                        },
                    })
                    .then((response) => {
                        this.listFrecuencias = response.data;
                    });
            } else {
                this.listFrecuencias = [];
            }
        },
        getPlanProgramacion() {
            if (
                this.oPlanMantenimiento.programacion != "" &&
                this.oPlanMantenimiento.fecha_final != "" &&
                this.oPlanMantenimiento.frecuencia_id != ""
            ) {
                this.loading = true;
                let obtiene = true;
                let mensaje = "";
                let fecha = "";
                if (
                    this.oPlanMantenimiento.programacion ==
                    "ÚLTIMA VEZ QUE SE PROGRAMÓ"
                ) {
                    fecha = this.oPlanMantenimiento.ultima_fecha_programada;
                    if (
                        !this.oPlanMantenimiento.ultima_fecha_programada ||
                        this.oPlanMantenimiento.ultima_fecha_programada == ""
                    ) {
                        obtiene = false;
                        mensaje = "Debes indicar la última fecha programada";
                    }
                }
                if (
                    this.oPlanMantenimiento.programacion ==
                    "ÚLTIMA VEZ QUE SE TERMINÓ"
                ) {
                    fecha = this.oPlanMantenimiento.ultima_fecha_terminada;
                    if (
                        !this.oPlanMantenimiento.ultima_fecha_terminada ||
                        this.oPlanMantenimiento.ultima_fecha_terminada == ""
                    ) {
                        obtiene = false;
                        mensaje = "Debes indicar la última fecha terminada";
                    }
                }
                if (obtiene) {
                    axios
                        .get("/admin/plan_mantenimientos/getPlanProgramacion", {
                            params: {
                                fecha_recibida: fecha,
                                fecha_final:
                                    this.oPlanMantenimiento.fecha_final,
                                frecuencia_id:
                                    this.oPlanMantenimiento.frecuencia_id,
                            },
                        })
                        .then((response) => {
                            this.oPlanMantenimiento.programacions =
                                response.data;
                            let self = this;
                            setTimeout(() => {
                                self.loading = false;
                            }, 500);
                        });
                } else {
                    this.loading = false;
                    Swal.fire({
                        icon: "error",
                        title: "Completa el formulario",
                        html: mensaje,
                        showConfirmButton: true,
                        confirmButtonColor: "#149FDA",
                        confirmButtonText: "Aceptar",
                    });
                }
            }
        },
        getTiempoGama() {
            if (this.oPlanMantenimiento.gama_id != "") {
                axios
                    .get("/admin/gama_mantenimientos/getTiempo/" + this.oPlanMantenimiento.gama_id)
                    .then((response) => {
                        this.oPlanMantenimiento.tiempo = response.data;
                    });
            } else {
                this.oPlanMantenimiento.tiempo = "";
            }
        },
        setRegistro() {
            this.enviando = true;
            try {
                this.textoBtn = "Enviando...";
                let url = "/admin/plan_mantenimientos";
                if (this.accion == "edit") {
                    url =
                        "/admin/plan_mantenimientos/" +
                        this.oPlanMantenimiento.id;
                    this.oPlanMantenimiento["_method"] = "PUT";
                }
                axios
                    .post(url, this.oPlanMantenimiento)
                    .then((res) => {
                        this.enviando = false;
                        if (res.data.sw) {
                            Swal.fire({
                                icon: "success",
                                title: res.data.msj,
                                showConfirmButton: false,
                                timer: 1500,
                            });
                            this.limpiaPlanMantenimiento();
                            this.$router.push({
                                name: "plan_mantenimientos.index",
                            });
                            this.errors = [];
                            if (this.accion == "edit") {
                                this.textoBtn = "Actualizar";
                            } else {
                                this.textoBtn = "Registrar";
                            }
                        } else {
                            Swal.fire({
                                icon: "info",
                                title: "Atención",
                                html: res.data.msj,
                                showConfirmButton: false,
                                timer: 2000,
                            });
                        }
                    })
                    .catch((error) => {
                        this.enviando = false;
                        if (this.accion == "edit") {
                            this.textoBtn = "Actualizar";
                        } else {
                            this.textoBtn = "Registrar";
                        }
                        if (error.response) {
                            if (error.response.status === 422) {
                                this.errors = error.response.data.errors;
                                let mensaje = `<ul class="text-left">`;
                                for (let key in this.errors) {
                                    if (this.errors.hasOwnProperty(key)) {
                                        const value = this.errors[key];
                                        if (Array.isArray(value)) {
                                            value.forEach((error) => {
                                                mensaje += `<li><span>${error.trim()}</span></li>`;
                                            });
                                        }
                                    }
                                }
                                mensaje += `<ul/>`;
                                Swal.fire({
                                    icon: "error",
                                    title: "Completa el formulario",
                                    html: mensaje,
                                    showConfirmButton: true,
                                    confirmButtonColor: "#149FDA",
                                    confirmButtonText: "Aceptar",
                                });
                            }
                            if (
                                error.response.status === 420 ||
                                error.response.status === 419 ||
                                error.response.status === 401
                            ) {
                                window.location = "/";
                            }
                            if (error.response.status === 500) {
                                Swal.fire({
                                    icon: "error",
                                    title: "Error",
                                    html: error.response.data.message,
                                    showConfirmButton: false,
                                    timer: 2000,
                                });
                            }
                        }
                    });
            } catch (e) {
                this.enviando = false;
                console.log(e);
            }
        },
        limpiaPlanMantenimiento() {
            this.errors = [];
            this.oPlanMantenimiento.codificacion = "";
            this.oPlanMantenimiento.subunidad_id = "";
            this.oPlanMantenimiento.gama_id = "";
            this.oPlanMantenimiento.pm = "";
            this.oPlanMantenimiento.prioridad = "";
            this.oPlanMantenimiento.tiempo = "";
            this.oPlanMantenimiento.dias = "";
            this.oPlanMantenimiento.tipo_mantenimiento = "";
            this.oPlanMantenimiento.ultima_fecha_programada = "";
            this.oPlanMantenimiento.ultima_fecha_terminada = "";
            this.oPlanMantenimiento.programacion = "";
            this.oPlanMantenimiento.fecha_final = "";
            this.oPlanMantenimiento.variable_control_id = "";
            this.oPlanMantenimiento.frecuencia_id = "";
            this.oPlanMantenimiento.programacions = [];
        },
    },
};
</script>

<style></style>
