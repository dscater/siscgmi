<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Historial de tiempo Disponible</h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-4 form-group">
                                        <label>Año*</label>
                                        <select
                                            name=""
                                            id=""
                                            class="form-control"
                                            v-model="oHistorialTiempo.anio"
                                            @change="verificaRegistro"
                                        >
                                            <option value="">
                                                Seleccione...
                                            </option>
                                            <option
                                                v-for="(
                                                    item, index
                                                ) in listAnios"
                                                :value="item"
                                                :key="index"
                                            >
                                                {{ item }}
                                            </option>
                                        </select>
                                        <span
                                            class="error invalid-feedback"
                                            v-if="errors.anio"
                                            v-text="errors.anio[0]"
                                        ></span>
                                    </div>
                                    <div class="col-md-4 form-group">
                                        <label>Mes*</label>
                                        <select
                                            name=""
                                            id=""
                                            class="form-control"
                                            v-model="oHistorialTiempo.mes"
                                            @change="verificaRegistro"
                                        >
                                            <option value="">
                                                Seleccione...
                                            </option>
                                            <option value="1">ENERO</option>
                                            <option value="2">FEBRERO</option>
                                            <option value="3">MARZO</option>
                                            <option value="4">ABRIL</option>
                                            <option value="5">MAYO</option>
                                            <option value="6">JUNIO</option>
                                            <option value="7">JULIO</option>
                                            <option value="8">AGOSTO</option>
                                            <option value="9">
                                                SEPTIEMBRE
                                            </option>
                                            <option value="10">OCTUBRE</option>
                                            <option value="11">
                                                NOVIMEBRE
                                            </option>
                                            <option value="12">
                                                DICIEMBRE
                                            </option>
                                        </select>
                                        <span
                                            class="error invalid-feedback"
                                            v-if="errors.mes"
                                            v-text="errors.mes[0]"
                                        ></span>
                                    </div>
                                    <div class="col-md-4 form-group">
                                        <label>Equipo*</label>
                                        <el-select
                                            placeholder="Seleccionar equipo"
                                            class="w-100"
                                            :class="{
                                                'is-invalid': errors.equipo_id,
                                            }"
                                            v-model="oHistorialTiempo.equipo_id"
                                            clearable
                                            filterable
                                            @change="verificaRegistro"
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
                                </div>
                                <div class="row">
                                    <div class="col-md-4 form-group">
                                        <label>Códificación*</label>
                                        <el-input
                                            placeholder="Código"
                                            :class="{
                                                'is-invalid':
                                                    errors.codificacion,
                                            }"
                                            v-model="
                                                oHistorialTiempo.codificacion
                                            "
                                            clearable
                                        >
                                        </el-input>
                                        <span
                                            class="error invalid-feedback"
                                            v-if="errors.codificacion"
                                            v-text="errors.codificacion[0]"
                                        ></span>
                                    </div>
                                </div>
                                <div
                                    class="row"
                                    v-if="
                                        oHistorialTiempo.detalle_tiempos
                                            .length > 0
                                    "
                                >
                                    <div class="col-md-12">
                                        <table class="table table-bordered">
                                            <thead>
                                                <tr>
                                                    <th>FECHA</th>
                                                    <th>TIEMPO DISPONIBLE</th>
                                                    <th>COMENTARIOS</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr
                                                    v-for="(
                                                        item, index
                                                    ) in oHistorialTiempo.detalle_tiempos"
                                                >
                                                    <td>{{ item.fecha }}</td>
                                                    <td>
                                                        <input
                                                            type="number"
                                                            v-model="
                                                                item.tiempo
                                                            "
                                                            class="form-control"
                                                            @change="
                                                                obtenerTotal
                                                            "
                                                            @keup="obtenerTotal"
                                                        />
                                                    </td>
                                                    <td>
                                                        <input
                                                            type="text"
                                                            v-model="
                                                                item.comentario
                                                            "
                                                            class="form-control"
                                                        />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td v-text="MesTxt"></td>
                                                    <td>
                                                        {{
                                                            this
                                                                .oHistorialTiempo
                                                                .total_tiempo
                                                        }}
                                                    </td>
                                                    <td></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="col-md-4">
                                        <button
                                            class="btn btn-primary"
                                            :disabled="enviando"
                                            @click="setRegistro"
                                        >
                                            <i class="fa fa-save"></i>
                                            <span v-text="txtBoton"></span>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</template>

<script>
export default {
    data() {
        return {
            permisos: localStorage.getItem("permisos"),
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            oHistorialTiempo: {
                id: 0,
                anio: "",
                mes: "",
                equipo_id: "",
                codificacion: "",
                total_tiempo: 0,
                detalle_tiempos: [],
            },
            listEquipos: [],
            listAnios: [this.$moment().format("YYYY")],
            existe_registro: false,
            enviando: false,
            errors: [],
            total_anterior: 0,
        };
    },
    computed: {
        MesTxt() {
            const meses = [
                "ENERO",
                "FEBRERO",
                "MARZO",
                "ABRIL",
                "MAYO",
                "JUNIO",
                "JULIO",
                "AGOSTO",
                "SEPTIEMBRE",
                "OCTUBRE",
                "NOVIEMBRE",
                "DICIEMBRE",
            ];
            const mesIndex = parseInt(this.oHistorialTiempo.mes, 10) - 1;
            let texto_mes = meses[mesIndex] ? meses[mesIndex] : "Mes inválido";
            return `TIEMPO DISPONIBLE MES ${texto_mes}`;
        },
        txtBoton() {
            if (this.enviando) {
                return "Enviando...";
            }
            if (this.existe_registro) {
                return "ACTUALIZAR REGISTRO";
            }
            return "GUARDAR";
        },
    },
    mounted() {
        this.loadingWindow.close();
        this.getAnios();
        this.getEquipos();
    },
    methods: {
        verificaRegistro() {
            if (
                this.oHistorialTiempo.anio != "" &&
                this.oHistorialTiempo.mes != "" &&
                this.oHistorialTiempo.equipo_id != ""
            ) {
                axios
                    .get("/admin/historial_tiempos/verifica_registro", {
                        params: {
                            anio: this.oHistorialTiempo.anio,
                            mes: this.oHistorialTiempo.mes,
                            equipo_id: this.oHistorialTiempo.equipo_id,
                        },
                    })
                    .then((response) => {
                        let existe = response.data.existe;
                        if (existe) {
                            this.oHistorialTiempo =
                                response.data.historial_tiempo;
                            this.oHistorialTiempo.equipo_id =
                                response.data.historial_tiempo.equipo_id;
                            this.existe_registro = true;
                        } else {
                            this.existe_registro = false;
                            this.oHistorialTiempo.detalle_tiempos =
                                response.data.detalle_tiempos;
                            this.oHistorialTiempo.codificacion = "";
                        }
                        this.total_anterior = response.data.total_anterior;
                        this.obtenerTotal();
                    });
            } else {
                this.existe_registro = false;
                this.oHistorialTiempo.id = 0;
                this.oHistorialTiempo.detalle_tiempos = [];
            }
        },
        getEquipos() {
            axios.get("/admin/equipos").then((response) => {
                this.listEquipos = response.data.equipos;
            });
        },
        getAnios() {
            axios
                .get("/admin/orden_trabajos/getAniosOt")
                .then((response) => {
                    this.listAnios = response.data;
                })
                .catch((error) => {
                    this.listAnios = [$moment().format("YYYY")];
                });
        },
        setRegistro() {
            this.enviando = true;
            try {
                let url = "/admin/historial_tiempos";

                if (this.existe_registro) {
                    url =
                        "/admin/historial_tiempos/" + this.oHistorialTiempo.id;
                    this.oHistorialTiempo["_method"] = "PUT";
                }
                axios
                    .post(url, this.oHistorialTiempo)
                    .then((res) => {
                        this.enviando = false;
                        if (res.data.sw) {
                            Swal.fire({
                                icon: "success",
                                title: res.data.message,
                                showConfirmButton: false,
                                timer: 1500,
                            });
                            this.errors = [];

                            this.existe_registro = true;
                            this.oHistorialTiempo = res.data.historial_tiempo;
                            this.oHistorialTiempo.equipo_id = parseInt(
                                res.data.historial_tiempo.equipo_id
                            );
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
        obtenerTotal() {
            let total = this.oHistorialTiempo.detalle_tiempos.reduce(
                (total, objeto) => {
                    if (objeto["tiempo"]) {
                        return total + parseFloat(objeto["tiempo"]);
                    }
                    return total;
                },
                0
            );
            this.oHistorialTiempo.total_tiempo = total;
            this.oHistorialTiempo.total_tiempo += parseFloat(
                this.total_anterior
            );
        },
    },
};
</script>

<style></style>
