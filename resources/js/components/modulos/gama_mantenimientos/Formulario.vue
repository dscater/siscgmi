<template>
    <div class="row formGama">
        <div class="col-md-12">
            <form>
                <div class="row">
                    <div class="form-group col-md-12">
                        <label
                            :class="{
                                'text-danger': errors.codigo,
                            }"
                            >Código*</label
                        >
                        <el-input
                            placeholder="Código"
                            :class="{
                                'is-invalid': errors.codigo,
                            }"
                            v-model="oGamaMantenimiento.codigo"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.codigo"
                            v-text="errors.codigo[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-12">
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
                            v-model="oGamaMantenimiento.codificacion"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.codificacion"
                            v-text="errors.codificacion[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-12">
                        <label
                            :class="{
                                'text-danger': errors.subfamilia_id,
                            }"
                            >Seleccionar Subfamilia*</label
                        >
                        <el-select
                            placeholder="Seleccionar Subfamilia"
                            class="w-100"
                            :class="{
                                'is-invalid': errors.subfamilia_id,
                            }"
                            v-model="oGamaMantenimiento.subfamilia_id"
                            clearable
                        >
                            <el-option
                                v-for="item in listSubfamilias"
                                :key="item.id"
                                :value="item.id"
                                :label="item.full_name"
                            ></el-option>
                        </el-select>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.subfamilia_id"
                            v-text="errors.subfamilia_id[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-12">
                        <label
                            :class="{
                                'text-danger': errors.equipo_id,
                            }"
                            >Seleccionar equipo*</label
                        >
                        <el-select
                            placeholder="Seleccionar equipo"
                            class="w-100"
                            :class="{
                                'is-invalid': errors.equipo_id,
                            }"
                            v-model="oGamaMantenimiento.equipo_id"
                            clearable
                        >
                            <el-option
                                v-for="item in listEquipos"
                                :key="item.id"
                                :value="item.id"
                                :label="item.full_name"
                            ></el-option>
                        </el-select>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.equipo_id"
                            v-text="errors.equipo_id[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-12">
                        <label
                            :class="{
                                'text-danger': errors.descripcion,
                            }"
                            >Descripción</label
                        >
                        <el-input
                            type="textarea"
                            autosize
                            placeholder="Descripción"
                            :class="{
                                'is-invalid': errors.descripcion,
                            }"
                            v-model="oGamaMantenimiento.descripcion"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.descripcion"
                            v-text="errors.descripcion[0]"
                        ></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <h3 class="card-title font-weight-bold">TAREAS</h3>
                    </div>
                    <hr class="col-md-12" />
                    <div class="col-md-12">
                        <div
                            class="row tarea"
                            v-for="(
                                item, index
                            ) in oGamaMantenimiento.gama_detalles"
                        >
                            <button
                                type="button"
                                class="btn btn-sm btn-danger rounded btnEliminaTarea"
                                @click.prevent="eliminaTarea(index, item.id)"
                            >
                                X
                            </button>
                            <div class="form-group col-md-7">
                                <label>Tarea*</label>
                                <el-input
                                    placeholder="Tarea"
                                    :class="{
                                        'is-invalid':
                                            errors[
                                                'gama_detalles.' +
                                                    index +
                                                    '.tarea'
                                            ],
                                    }"
                                    v-model="item.tarea"
                                    clearable
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="
                                        errors[
                                            'gama_detalles.' + index + '.tarea'
                                        ]
                                    "
                                    v-text="
                                        errors[
                                            'gama_detalles.' + index + '.tarea'
                                        ][0]
                                    "
                                ></span>
                            </div>
                            <div class="form-group col-md-5">
                                <label>Tiempo (minutos)*</label>
                                <input
                                    type="number"
                                    placeholder="Tiempo"
                                    class="form-control"
                                    :class="{
                                        'is-invalid':
                                            errors[
                                                'gama_detalles.' +
                                                    index +
                                                    '.tiempo'
                                            ],
                                    }"
                                    v-model="item.tiempo"
                                    clearable
                                />
                                <span
                                    class="error invalid-feedback"
                                    v-if="
                                        errors[
                                            'gama_detalles.' + index + '.tiempo'
                                        ]
                                    "
                                    v-text="
                                        errors[
                                            'gama_detalles.' + index + '.tiempo'
                                        ][0]
                                    "
                                ></span>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-12">
                                <button
                                    type="button"
                                    class="btn btn-info btn-flat btn-block"
                                    @click="agregarTarea"
                                >
                                    <i class="fa fa-plus"></i> Agregar tarea
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-3">
                        <el-button
                            type="primary"
                            class="bg-primary"
                            :loading="enviando"
                            @click="setRegistro()"
                            :disabled="validaTareas"
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
        gama_mantenimiento: {
            type: Object,
            default: {
                id: 0,
                codigo: "",
                codificacion: "",
                subfamilia_id: "",
                equipo_id: "",
                descripcion: "",
                gama_detalles: [],
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
        gama_mantenimiento(newVal) {
            this.oGamaMantenimiento = newVal;
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
        validaTareas() {
            if (this.oGamaMantenimiento.gama_detalles.length <= 0) {
                return true;
            }
            return false;
        },
    },
    data() {
        return {
            user: JSON.parse(localStorage.getItem("user")),
            bModal: this.muestra_modal,
            enviando: false,
            errors: [],
            oGamaMantenimiento: this.gama_mantenimiento,
            listSubfamilias: [],
            listEquipos: [],
            eliminados: [],
        };
    },
    mounted() {
        this.bModal = this.muestra_modal;
        this.getEquipos();
        this.getSubfamilias();
    },
    methods: {
        getEquipos() {
            axios.get("/admin/equipos").then((response) => {
                this.listEquipos = response.data.equipos;
            });
        },
        getSubfamilias() {
            axios.get("/admin/sub_familias").then((response) => {
                this.listSubfamilias = response.data.sub_familias;
            });
        },
        setRegistro() {
            this.enviando = true;
            try {
                this.textoBtn = "Enviando...";
                let url = "/admin/gama_mantenimientos";
                let formdata = new FormData();
                if (this.oGamaMantenimiento.codigo.trim() != "") {
                    formdata.append("codigo", this.oGamaMantenimiento.codigo);
                }

                if (this.oGamaMantenimiento.codificacion.trim() != "") {
                    formdata.append(
                        "codificacion",
                        this.oGamaMantenimiento.codificacion
                    );
                }
                if (this.oGamaMantenimiento.subfamilia_id) {
                    formdata.append(
                        "subfamilia_id",
                        this.oGamaMantenimiento.subfamilia_id
                    );
                }
                if (this.oGamaMantenimiento.equipo_id) {
                    formdata.append(
                        "equipo_id",
                        this.oGamaMantenimiento.equipo_id
                    );
                }
                if (this.oGamaMantenimiento.descripcion.trim() != "") {
                    formdata.append(
                        "descripcion",
                        this.oGamaMantenimiento.descripcion
                    );
                }
                if (this.oGamaMantenimiento.gama_detalles.lengt > 0) {
                    this.oGamaMantenimiento.gama_detalles.forEach((elem) => {
                        formdata.append("gama_detalles[]", elem);
                    });
                }

                if (this.accion == "edit") {
                    if (this.eliminados.length > 0) {
                        this.oGamaMantenimiento.eliminados = this.eliminados;
                    }
                    url =
                        "/admin/gama_mantenimientos/" +
                        this.oGamaMantenimiento.id;
                    this.oGamaMantenimiento["_method"] = "PUT";
                }
                axios
                    .post(url, this.oGamaMantenimiento)
                    .then((res) => {
                        this.enviando = false;
                        if (res.data.sw) {
                            Swal.fire({
                                icon: "success",
                                title: res.data.message,
                                showConfirmButton: false,
                                timer: 1500,
                            });
                            this.$router.push({
                                name: "gama_mantenimientos.index",
                            });
                            this.limpiaGamaMantenimiento();
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
                                html: res.data.message,
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
                                let mensaje = `<ul class="text-center">`;
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
        limpiaGamaMantenimiento() {
            this.errors = [];
            this.oGamaMantenimiento.codigo = "";
            this.oGamaMantenimiento.subfamilia_id = "";
            this.oGamaMantenimiento.equipo_id = "";
            this.oGamaMantenimiento.descripcion = "";
            this.oGamaMantenimiento.gama_detalles = [];
        },
        agregarTarea() {
            this.oGamaMantenimiento.gama_detalles.push({
                id: 0,
                tarea: "",
                tiempo: 5,
            });
        },
        eliminaTarea(index, id) {
            if (id != 0) {
                this.eliminados.push(id);
            }
            this.oGamaMantenimiento.gama_detalles.splice(index, 1);
        },
    },
};
</script>

<style>
.formGama .tarea {
    position: relative;
}
.formGama .btnEliminaTarea {
    position: absolute;
    top: 0;
    right: 0;
    z-index: 100;
}
</style>
